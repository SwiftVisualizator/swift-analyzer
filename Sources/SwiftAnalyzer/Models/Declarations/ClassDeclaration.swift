//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 06.02.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

/// Class or actor declaration.
public struct ClassDeclaration: Declaration, Namable, Keywordable, Wrappable, Modifiable, GenericParametable {
	
	// MARK: - Exposed properties
	
	public let identifier: String = UUID().uuidString
	
	public let wrappers: [Wrapper]
	
	public let modifiers: [Modifier]
	
	public let keyword: String
	
	public let name: String
	
	public let inheritances: [String]
	
	public let genericParameters: [GenericParameter]
	
	// MARK: Init
	
	/// Creates an instance from SwiftSyntax model.
	init(node: ClassDeclSyntax) {
		self.wrappers = node.attributes?
			.compactMap { $0.as(AttributeSyntax.self) }
			.map(Wrapper.init(node:)) ?? []
		self.modifiers = node.modifiers?
			.map(Modifier.init(node:)) ?? []
		self.keyword = node.classOrActorKeyword.text.trimmed
		self.name = node.identifier.text.trimmed
		self.inheritances = node.inheritanceClause?.inheritedTypeCollection
			.map(\.typeName.description.trimmed) ?? []
		self.genericParameters = node.genericParameterClause?.genericParameterList
			.map(GenericParameter.init(node:)) ?? []
	}
	
}

// MARK: - CustomStringConvertible

extension ClassDeclaration: CustomStringConvertible {
	
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
