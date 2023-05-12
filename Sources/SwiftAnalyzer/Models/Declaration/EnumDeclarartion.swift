//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 20.02.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

/// Enum declaration.
public struct EnumDeclaration:
	Declaration,
	Namable,
	NestedlyNamable,
	Keywordable,
	Wrappable,
	Modifiable,
	GenericParametable,
	Inheritable,
	GenericRequirementable,
	LocationMetaHolder,
	FileMetaHolder,
	DocStringMetaHolder
{
	
	// MARK: Exposed properties
	
	public var docStringMeta: DocStringMeta?
	
	public var fileMeta: FileMeta?
	
	public var locationMeta: LocationMeta?
	
	public let wrappers: [Wrapper]
	
	public let modifiers: [Modifier]
	
	public let keyword: String
	
	public let name: String
	
	public let nestedName: String
	
	public let inheritances: [String]
	
	public let genericParameters: [GenericParameter]
	
	public let genericRequirements: [GenericRequirement]
	
	// MARK: Init
	
	/// Creates an instance from SwiftSyntax model.
	init(node: EnumDeclSyntax) {
		self.wrappers = node.attributes?
			.compactMap { $0.as(AttributeSyntax.self) }
			.map(Wrapper.init(node:)) ?? []
		self.modifiers = node.modifiers?
			.map(Modifier.init(node:)) ?? []
		self.keyword = node.enumKeyword.text.trimmed
		self.name = node.identifier.text.trimmed
		self.nestedName = (
			node.declarationParentNameChain.reversed() +
			[node.identifier.text.trimmed]
		).joined(separator: ".")
		self.inheritances = node.inheritanceClause?.inheritedTypeCollection
			.map(\.typeName.description.trimmed) ?? []
		self.genericParameters = node.genericParameters?.genericParameterList
			.map(GenericParameter.init(node:)) ?? []
		self.genericRequirements = node.genericWhereClause?.requirementList
			.compactMap(GenericRequirement.init(node:)) ?? []
		self.docStringMeta = DocStringMeta(node: node)
	}
	
}

// MARK: - CustomStringConvertible

extension EnumDeclaration: CustomStringConvertible {
	
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
		if !inheritances.isEmpty {
			result += ": "
			result += inheritances.joined(separator: ", ")
		}
		if !genericRequirements.isEmpty {
			result += "where "
			result += genericRequirements.map(\.description).joined(separator: ", ")
		}
		return result
	}
	
}

