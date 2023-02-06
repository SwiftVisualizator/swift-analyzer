//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 06.02.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

/// Protocol declaration.
public struct ProtocolDeclaration: Declaration {
	
	// MARK: - Exposed properties
	
	/// Declaration list(ordered) of wrappers. For example, `@main`, `@available(iOS 13, *)`.
	public internal(set) var wrappers: [Wrapper]
	
	/// Declaration modifiers. For exmaple, `public`, `open`.
	public internal(set) var modifiers: [Modifier]
	
	/// Static keyword of the declaration. Can be *protcol* only.
	public internal(set) var keyword: String
	
	/// Protocol name.
	public internal(set) var name: String
	
	/// Ordered list of the protocol inheritances. Inheritances are represented as protocol names.
	public internal(set) var inheritances: [String]
	
	// MARK: Init
	
	/// Creates an instance from SwiftSyntax model.
	init(node: ProtocolDeclSyntax) {
		self.wrappers = node.attributes?
			.compactMap { $0.as(AttributeSyntax.self) }
			.map(Wrapper.init(node:)) ?? []
		self.modifiers = node.modifiers?
			.map(Modifier.init(node:)) ?? []
		self.keyword = node.protocolKeyword.text.trimmed
		self.name = node.identifier.text.trimmed
		self.inheritances = node.inheritanceClause?.inheritedTypeCollection
			.map(\.typeName.description.trimmed) ?? []
	}
	
}

// MARK: - CustomStringConvertible

extension ProtocolDeclaration: CustomStringConvertible {
	
	public var description: String {
		var result: String = ""
		result += (
			wrappers.map(\.description) +
			modifiers.map(\.description) +
			[keyword] +
			[name]
		).joined(separator: " ").asString
		if !inheritances.isEmpty {
			result += ": "
			result += inheritances.joined(separator: ", ")
		}
		return result
	}
	
}
