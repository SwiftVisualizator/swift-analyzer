//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 11.03.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

public struct TypealiasDeclaration: Declaration, Wrappable, Keywordable, Namable, GenericParametable, GenericRequirementable {
	
	// MARK: Exposed properties
	
	public let wrappers: [Wrapper]
	
	public let modifiers: [Modifier]
	
	public let keyword: String
	
	public let name: String
	
	/// Inital value (a type) if present.
	public let initialValue: String?
	
	public let genericParameters: [GenericParameter]
	
	public let genericRequirements: [GenericRequirement]
	
	// MARK: Init
	
	init(node: TypealiasDeclSyntax) {
		self.wrappers = node.attributes?
			.compactMap { $0.as(AttributeSyntax.self) }
			.map(Wrapper.init(node:)) ?? []
		self.modifiers = node.modifiers?
			.map(Modifier.init(node:)) ?? []
		self.keyword = node.typealiasKeyword.text.trimmed
		self.name = node.identifier.text.trimmed
		self.initialValue = node.initializer?.value.description.trimmed
		self.genericParameters = node.genericParameterClause?.genericParameterList
			.map(GenericParameter.init(node:)) ?? []
		self.genericRequirements = node.genericWhereClause?.requirementList
			.compactMap(GenericRequirement.init(node:)) ?? []
	}
	
}

// MARK: - CustomStringConvertible

extension TypealiasDeclaration: CustomStringConvertible {
	
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
		if let initialValue {
			result += " = \(initialValue)"
		}
		if !genericRequirements.isEmpty {
			result += " where "
			result += genericRequirements.map(\.description).joined(separator: ", ")
		}
		return result
	}
	
}
