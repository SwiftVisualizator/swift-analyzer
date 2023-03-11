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

final class ProtocolDeclarationTests: XCTestCase {
	
	// MARK: - Test methods
	
	func testProtocolDeclarationAttributeParsing() throws {
		let string = #"""
		@available(*, unavailable)
		public protocol Persistable: Codable { }
		"""#
		let parsedProtocol: ProtocolDeclaration = try parseSingleProtocol(from: string)
		XCTAssertEqual(parsedProtocol.wrappers.count, 1)
		XCTAssertEqual(parsedProtocol.wrappers[0].name, "available")
		XCTAssertEqual(parsedProtocol.wrappers[0].parameters.count, 2)
		XCTAssertEqual(parsedProtocol.wrappers[0].parameters[0].value, "*")
		XCTAssertEqual(parsedProtocol.wrappers[0].parameters[1].value, "unavailable")
	}
	
	func testProtocolDeclarationModifierParsing() throws {
		let string = #"""
		private protocol Persistable: Codable, Equatable { }
		"""#
		let parsedProtocol: ProtocolDeclaration = try parseSingleProtocol(from: string)
		XCTAssertEqual(parsedProtocol.modifiers.count, 1)
		XCTAssertEqual(parsedProtocol.modifiers[0].name, "private")
	}
	
	func testProtocolDeclarationKeywordParsing() throws {
		let string = #"""
		protocol Persistable { }
		"""#
		let parsedProtocol: ProtocolDeclaration = try parseSingleProtocol(from: string)
		XCTAssertEqual(parsedProtocol.keyword, "protocol")
	}
	
	func testProtocolDeclarationNameParsing() throws {
		let string = #"""
		protocol Persistable { }
		"""#
		let parsedProtocol: ProtocolDeclaration = try parseSingleProtocol(from: string)
		XCTAssertEqual(parsedProtocol.name, "Persistable")
	}
	
	func testProtocolDeclarationInheritanceParsing() throws {
		let string = #"""
		protocol Persistable: Codable, Equatable { }
		"""#
		let parsedProtocol: ProtocolDeclaration = try parseSingleProtocol(from: string)
		XCTAssertEqual(parsedProtocol.inheritances, ["Codable", "Equatable"])
	}
	
	func testProtocolDeclarationFullParsing() throws {
		let string = #"""
		@available(iOS 13, *)
		public protocol Persistable: Hashable, Equatable, Codable {
		
		}
		"""#
		let parsedProtocol: ProtocolDeclaration = try parseSingleProtocol(from: string)
		
		XCTAssertEqual(parsedProtocol.wrappers.count, 1)
		XCTAssertEqual(parsedProtocol.wrappers[0].name, "available")
		XCTAssertEqual(parsedProtocol.wrappers[0].parameters.count, 2)
		XCTAssertEqual(parsedProtocol.wrappers[0].parameters[0].value, "iOS 13")
		XCTAssertEqual(parsedProtocol.wrappers[0].parameters[1].value, "*")
		
		XCTAssertEqual(parsedProtocol.modifiers.count, 1)
		XCTAssertEqual(parsedProtocol.modifiers[0].name, "public")
		
		XCTAssertEqual(parsedProtocol.keyword, "protocol")
		XCTAssertEqual(parsedProtocol.name, "Persistable")
	}
	
	// MARK: - Private methods
	
	private func parseSingleProtocol(from string: String) throws -> ProtocolDeclaration {
		let foundProtocols = try analyze(text: string).protocolDeclarations
		XCTAssertEqual(foundProtocols.count, 1)
		return foundProtocols.first!
	}
	
}
