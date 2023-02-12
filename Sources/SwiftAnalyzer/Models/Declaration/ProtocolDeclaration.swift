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
public struct ProtocolDeclaration: Declaration, Namable, Keywordable, Wrappable, Modifiable, Inheritable {
	
	// MARK: - Exposed properties
	
	public let identifier: String = UUID().uuidString
	
	public let wrappers: [Wrapper]
	
	public let modifiers: [Modifier]

	public let keyword: String
	
	public let name: String

	public let inheritances: [String]
	
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
