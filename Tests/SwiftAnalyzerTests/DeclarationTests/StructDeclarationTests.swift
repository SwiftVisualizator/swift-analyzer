//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 11.03.2023.
//

import SwiftSyntax
import XCTest
@testable import SwiftAnalyzer

// MARK: - Tests

final class StructDeclarationTests: XCTestCase {
	
	// MARK: - Test methods
	
	func testStructDeclarationAttributeParsing() throws {
		let string = #"""
		@available(*, unavailable)
		public struct User: Equatable { }
		"""#
		let parsedStruct: StructDeclaration = try parseSingleStruct(from: string)
		XCTAssertEqual(parsedStruct.wrappers.count, 1)
		XCTAssertEqual(parsedStruct.wrappers[0].name, "available")
		XCTAssertEqual(parsedStruct.wrappers[0].parameters.count, 2)
		XCTAssertEqual(parsedStruct.wrappers[0].parameters[0].value, "*")
		XCTAssertEqual(parsedStruct.wrappers[0].parameters[1].value, "unavailable")
	}
	
	func testStructDeclarationModifierParsing() throws {
		let string = #"""
		private struct User: Equatable, Codable { }
		"""#
		let parsedStruct: StructDeclaration = try parseSingleStruct(from: string)
		XCTAssertEqual(parsedStruct.modifiers.count, 1)
		XCTAssertEqual(parsedStruct.modifiers[0].name, "private")
	}
	
	func testStructDeclarationKeywordParsing() throws {
		let string = #"""
		struct User { }
		"""#
		let parsedStruct: StructDeclaration = try parseSingleStruct(from: string)
		XCTAssertEqual(parsedStruct.keyword, "struct")
	}
	
	func testStructDeclarationNameParsing() throws {
		let string = #"""
		struct User { }
		"""#
		let parsedStruct: StructDeclaration = try parseSingleStruct(from: string)
		XCTAssertEqual(parsedStruct.name, "User")
	}
	
	func testStructDeclarationInheritanceParsing() throws {
		let string = #"""
		struct User: Equatable, Codable { }
		"""#
		let parsedStruct: StructDeclaration = try parseSingleStruct(from: string)
		XCTAssertEqual(parsedStruct.inheritances, ["Equatable", "Codable"])
	}
	
	func testStructDeclarationGenericParameterParsing() throws {
		let string = #"""
		struct User<A: Codable, B> { }
		"""#
		let parsedStruct: StructDeclaration = try parseSingleStruct(from: string)
		XCTAssertEqual(parsedStruct.genericParameters.count, 2)
		XCTAssertEqual(parsedStruct.genericParameters[0].name, "A")
		XCTAssertEqual(parsedStruct.genericParameters[0].constraintType, "Codable")
		XCTAssertEqual(parsedStruct.genericParameters[1].name, "B")
		XCTAssertEqual(parsedStruct.genericParameters[1].constraintType, nil)
	}

	func testStructDeclarationGenericRequirementParsing() throws {
		let string = #"""
		struct User<A, B> where A: Codable, B == Equatable { }
		"""#
		let parsedStruct: StructDeclaration = try parseSingleStruct(from: string)
		XCTAssertEqual(parsedStruct.genericRequirements.count, 2)
		XCTAssertEqual(parsedStruct.genericRequirements[0].leadingType, "A")
		XCTAssertEqual(parsedStruct.genericRequirements[0].relation, GenericRequirement.Relation.conforms)
		XCTAssertEqual(parsedStruct.genericRequirements[0].trailingType, "Codable")
		XCTAssertEqual(parsedStruct.genericRequirements[1].leadingType, "B")
		XCTAssertEqual(parsedStruct.genericRequirements[1].relation, GenericRequirement.Relation.equals)
		XCTAssertEqual(parsedStruct.genericRequirements[1].trailingType, "Equatable")
	}
	
	func testStructDeclarationFullParsing() throws {
		let string = #"""
		@available(iOS 13, *)
		@propertyWrapper public struct Persistable<
			Storage: LocalStorage,
			Key,
			Content
		>: Hashable, Codable where Content == LocalStorage.Content, Key: Hashable {
			
		}
		"""#
		let parsedStruct: StructDeclaration = try parseSingleStruct(from: string)
		
		XCTAssertEqual(parsedStruct.wrappers.count, 2)
		XCTAssertEqual(parsedStruct.wrappers[0].name, "available")
		XCTAssertEqual(parsedStruct.wrappers[0].parameters.count, 2)
		XCTAssertEqual(parsedStruct.wrappers[0].parameters[0].value, "iOS 13")
		XCTAssertEqual(parsedStruct.wrappers[0].parameters[1].value, "*")
		XCTAssertEqual(parsedStruct.wrappers[1].name, "propertyWrapper")
		XCTAssertEqual(parsedStruct.wrappers[1].parameters.count, 0)
		
		XCTAssertEqual(parsedStruct.modifiers.count, 1)
		XCTAssertEqual(parsedStruct.modifiers[0].name, "public")
		
		XCTAssertEqual(parsedStruct.keyword, "struct")
		XCTAssertEqual(parsedStruct.name, "Persistable")
		
		XCTAssertEqual(parsedStruct.genericParameters.count, 3)
		XCTAssertEqual(parsedStruct.genericParameters[0].name, "Storage")
		XCTAssertEqual(parsedStruct.genericParameters[0].constraintType, "LocalStorage")
		XCTAssertEqual(parsedStruct.genericParameters[1].name, "Key")
		XCTAssertEqual(parsedStruct.genericParameters[1].constraintType, nil)
		XCTAssertEqual(parsedStruct.genericParameters[2].name, "Content")
		XCTAssertEqual(parsedStruct.genericParameters[2].constraintType, nil)
		
		XCTAssertEqual(parsedStruct.inheritances, ["Hashable", "Codable"])
		
		XCTAssertEqual(parsedStruct.genericRequirements.count, 2)
		XCTAssertEqual(parsedStruct.genericRequirements[0].leadingType, "Content")
		XCTAssertEqual(parsedStruct.genericRequirements[0].relation, GenericRequirement.Relation.equals)
		XCTAssertEqual(parsedStruct.genericRequirements[0].trailingType, "LocalStorage.Content")
		XCTAssertEqual(parsedStruct.genericRequirements[1].leadingType, "Key")
		XCTAssertEqual(parsedStruct.genericRequirements[1].relation, GenericRequirement.Relation.conforms)
		XCTAssertEqual(parsedStruct.genericRequirements[1].trailingType, "Hashable")
	}
		
	// MARK: - Private methods
	
	private func parseSingleStruct(from string: String) throws -> StructDeclaration {
		let foundStructs = try analyze(text: string).structDeclarations
		XCTAssertEqual(foundStructs.count, 1)
		return foundStructs.first!
	}
	
}
