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

final class ClassDeclarationTests: XCTestCase {
	
	// MARK: - Test methods
	
	func testClassDeclarationAttributeParsing() throws {
		let string = #"""
		@available(*, unavailable)
		public class User: Equatable { }
		"""#
		let parsedClass: ClassDeclaration = try parseSingleClass(from: string)
		XCTAssertEqual(parsedClass.wrappers.count, 1)
		XCTAssertEqual(parsedClass.wrappers[0].name, "available")
		XCTAssertEqual(parsedClass.wrappers[0].parameters.count, 2)
		XCTAssertEqual(parsedClass.wrappers[0].parameters[0].value, "*")
		XCTAssertEqual(parsedClass.wrappers[0].parameters[1].value, "unavailable")
	}
	
	func testClassDeclarationModifierParsing() throws {
		let string = #"""
		private class User: Equatable, Codable { }
		"""#
		let parsedClass: ClassDeclaration = try parseSingleClass(from: string)
		XCTAssertEqual(parsedClass.modifiers.count, 1)
		XCTAssertEqual(parsedClass.modifiers[0].name, "private")
	}
	
	func testClassDeclarationKeywordParsing() throws {
		let string = #"""
		class User { }
		"""#
		let parsedClass: ClassDeclaration = try parseSingleClass(from: string)
		XCTAssertEqual(parsedClass.keyword, "class")
	}
	
	func testClassDeclarationNameParsing() throws {
		let string = #"""
		class User { }
		"""#
		let parsedClass: ClassDeclaration = try parseSingleClass(from: string)
		XCTAssertEqual(parsedClass.name, "User")
	}
	
	func testClassDeclarationInheritanceParsing() throws {
		let string = #"""
		class User: Equatable, Codable { }
		"""#
		let parsedClass: ClassDeclaration = try parseSingleClass(from: string)
		XCTAssertEqual(parsedClass.inheritances, ["Equatable", "Codable"])
	}
	
	func testClassDeclarationGenericParameterParsing() throws {
		let string = #"""
		class User<A: Codable, B> { }
		"""#
		let parsedClass: ClassDeclaration = try parseSingleClass(from: string)
		XCTAssertEqual(parsedClass.genericParameters.count, 2)
		XCTAssertEqual(parsedClass.genericParameters[0].name, "A")
		XCTAssertEqual(parsedClass.genericParameters[0].constraintType, "Codable")
		XCTAssertEqual(parsedClass.genericParameters[1].name, "B")
		XCTAssertEqual(parsedClass.genericParameters[1].constraintType, nil)
	}
	
	func testClassDeclarationGenericRequirementParsing() throws {
		let string = #"""
		class User<A, B> where A: Codable, B == Equatable { }
		"""#
		let parsedClass: ClassDeclaration = try parseSingleClass(from: string)
		XCTAssertEqual(parsedClass.genericRequirements.count, 2)
		XCTAssertEqual(parsedClass.genericRequirements[0].leadingType, "A")
		XCTAssertEqual(parsedClass.genericRequirements[0].relation, GenericRequirement.Relation.conforms)
		XCTAssertEqual(parsedClass.genericRequirements[0].trailingType, "Codable")
		XCTAssertEqual(parsedClass.genericRequirements[1].leadingType, "B")
		XCTAssertEqual(parsedClass.genericRequirements[1].relation, GenericRequirement.Relation.equals)
		XCTAssertEqual(parsedClass.genericRequirements[1].trailingType, "Equatable")
	}
	
	func testClassDeclarationFullParsing() throws {
		let string = #"""
		@available(iOS 13, *)
		@propertyWrapper public class Persistable<
			Storage: LocalStorage,
			Key,
			Content
		>: Hashable, Codable where Content == LocalStorage.Content, Key: Hashable {
		
		}
		"""#
		let parsedClass: ClassDeclaration = try parseSingleClass(from: string)
		
		XCTAssertEqual(parsedClass.wrappers.count, 2)
		XCTAssertEqual(parsedClass.wrappers[0].name, "available")
		XCTAssertEqual(parsedClass.wrappers[0].parameters.count, 2)
		XCTAssertEqual(parsedClass.wrappers[0].parameters[0].value, "iOS 13")
		XCTAssertEqual(parsedClass.wrappers[0].parameters[1].value, "*")
		XCTAssertEqual(parsedClass.wrappers[1].name, "propertyWrapper")
		XCTAssertEqual(parsedClass.wrappers[1].parameters.count, 0)
		
		XCTAssertEqual(parsedClass.modifiers.count, 1)
		XCTAssertEqual(parsedClass.modifiers[0].name, "public")
		
		XCTAssertEqual(parsedClass.keyword, "class")
		XCTAssertEqual(parsedClass.name, "Persistable")
		
		XCTAssertEqual(parsedClass.genericParameters.count, 3)
		XCTAssertEqual(parsedClass.genericParameters[0].name, "Storage")
		XCTAssertEqual(parsedClass.genericParameters[0].constraintType, "LocalStorage")
		XCTAssertEqual(parsedClass.genericParameters[1].name, "Key")
		XCTAssertEqual(parsedClass.genericParameters[1].constraintType, nil)
		XCTAssertEqual(parsedClass.genericParameters[2].name, "Content")
		XCTAssertEqual(parsedClass.genericParameters[2].constraintType, nil)
		
		XCTAssertEqual(parsedClass.inheritances, ["Hashable", "Codable"])
		
		XCTAssertEqual(parsedClass.genericRequirements.count, 2)
		XCTAssertEqual(parsedClass.genericRequirements[0].leadingType, "Content")
		XCTAssertEqual(parsedClass.genericRequirements[0].relation, GenericRequirement.Relation.equals)
		XCTAssertEqual(parsedClass.genericRequirements[0].trailingType, "LocalStorage.Content")
		XCTAssertEqual(parsedClass.genericRequirements[1].leadingType, "Key")
		XCTAssertEqual(parsedClass.genericRequirements[1].relation, GenericRequirement.Relation.conforms)
		XCTAssertEqual(parsedClass.genericRequirements[1].trailingType, "Hashable")
	}
	
	// MARK: - Private methods
	
	private func parseSingleClass(from string: String) throws -> ClassDeclaration {
		let foundClasss = try analyze(text: string).classDeclarations
		XCTAssertEqual(foundClasss.count, 1)
		return foundClasss.first!
	}
	
}
