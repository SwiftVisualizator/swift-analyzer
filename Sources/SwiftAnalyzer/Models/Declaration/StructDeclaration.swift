//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 06.02.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

/// Struct declaration.
public struct StructDeclaration: Declaration {
	
	// MARK: - Exposed properties
	
	/// Declaration list(ordered) of wrappers. For example, `@main`, `@available(iOS 13, *)`.
	public internal(set) var wrappers: [Wrapper]
	
	/// Declaration modifiers. For exmaple, `public`, `final`.
	public internal(set) var modifiers: [Modifier]
	
	/// Static keyword of the declaration. Can be *string*.
	public internal(set) var keyword: String
	
	/// Struct name.
	public internal(set) var name: String
	
	/// Ordered list of declaration inheritances. Inheritances are represented as protocol names. For example, `: A, B`.
	public internal(set) var inheritances: [String]
	
	/// Ordered list of generic parameters. For example, `<A: Codable, B>`.
	public internal(set) var genericParameters: [GenericParameter]
	
	// MARK: Init
	
	/// Creates an instance from SwiftSyntax model.
	init(node: StructDeclSyntax) {
		self.wrappers = node.attributes?
			.compactMap { $0.as(AttributeSyntax.self) }
			.map(Wrapper.init(node:)) ?? []
		self.modifiers = node.modifiers?
			.map(Modifier.init(node:)) ?? []
		self.keyword = node.structKeyword.text.trimmed
		self.name = node.identifier.text.trimmed
		self.inheritances = node.inheritanceClause?.inheritedTypeCollection
			.map(\.typeName.description.trimmed) ?? []
		self.genericParameters = node.genericParameterClause?.genericParameterList
			.map(GenericParameter.init(node:)) ?? []
	}
	
}

// MARK: - CustomStringConvertible

extension StructDeclaration: CustomStringConvertible {
	
	public var description: String {
		var result: String = ""
		result += (
			wrappers.map(\.description) +
			modifiers.map(\.description) +
			[keyword] +
			[name]
		).joined(separator: " ").asString
		if !genericParameters.isEmpty {
			result += "<"
			result += genericParameters.map(\.description).joined(separator: ", ")
			result += ">"
		}
		if !inheritances.isEmpty {
			result += ": "
			result += inheritances.joined(separator: ", ")
		}
		return result
	}
	
}
