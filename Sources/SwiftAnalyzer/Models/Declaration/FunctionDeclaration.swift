//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 11.03.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

/// A function declaration.
public struct FunctionDeclaration: Declaration, Wrappable, Modifiable, Keywordable, GenericParametable, GenericRequirementable {
	
	// MARK: Exposed properties
	
	public let identifier: String = UUID().uuidString
	
	public let wrappers: [Wrapper]
	
	public let modifiers: [Modifier]
	
	public let keyword: String
	
	public let name: String
	
	public let signature: FunctionSignature
	
	public let genericParameters: [GenericParameter]
	
	public let genericRequirements: [GenericRequirement]
	
	// MARK: Init
	
	/// Creates an instance from SwiftSyntax model.
	init(node: FunctionDeclSyntax) {
		self.wrappers = node.attributes?
			.compactMap { $0.as(AttributeSyntax.self) }
			.map(Wrapper.init(node:)) ?? []
		self.modifiers = node.modifiers?
			.map(Modifier.init(node:)) ?? []
		self.keyword = node.funcKeyword.text.trimmed
		self.name = node.identifier.text.trimmed
		self.signature = FunctionSignature(node: node.signature)
		self.genericParameters = node.genericParameterClause?.genericParameterList
			.map(GenericParameter.init(node:)) ?? []
		self.genericRequirements = node.genericWhereClause?.requirementList
			.compactMap(GenericRequirement.init(node:)) ?? []
	}
	
}

// MARK: - CustomStringConvertible

extension FunctionDeclaration: CustomStringConvertible {
	
	public var description: String {
		var result: String = ""
		result += (
			wrappers.map(\.description) +
			modifiers.map(\.description) +
			[keyword, name]
		).joined(separator: " ").asString
		
		if !genericParameters.isEmpty {
			result += "<"
			result += genericParameters.map(\.description).joined(separator: ", ")
			result += ">"
		}
		
		result += signature.description
		
		if !genericRequirements.isEmpty {
			result += "where "
			result += genericRequirements.map(\.description).joined(separator: ", ")
		}
		
		return result
	}

}
