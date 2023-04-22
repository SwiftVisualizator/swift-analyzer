//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 11.03.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

/// An extension declaration.
public struct ExtensionDeclaration:
	Declaration,
	Wrappable,
	Modifiable,
	Keywordable,
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
	
	/// The type that this extension extends. For example, `UserModel` in `extension UserModel: Codable { }`.
	public let extendedType: String
	
	public let inheritances: [String]
	
	public let genericRequirements: [GenericRequirement]

	// MARK: Init
	
	init(node: ExtensionDeclSyntax) {
		self.wrappers = node.attributes?
			.compactMap { $0.as(AttributeSyntax.self) }
			.map(Wrapper.init(node:)) ?? []
		self.modifiers = node.modifiers?
			.map(Modifier.init(node:)) ?? []
		self.keyword = node.extensionKeyword.text.trimmed
		self.extendedType = node.extendedType.description.trimmed
		self.inheritances = node.inheritanceClause?.inheritedTypeCollection
			.map(\.typeName.description.trimmed) ?? []
		self.genericRequirements = node.genericWhereClause?.requirementList
			.compactMap(GenericRequirement.init(node:)) ?? []
		self.docStringMeta = DocStringMeta(node: node)
	}
	
}

// MARK: - CustomStringConvertible

extension ExtensionDeclaration: CustomStringConvertible {
	
	public var description: String {
		var result: String = ""
		result += (
			wrappers.map(\.description) +
			modifiers.map(\.description) +
			[keyword, extendedType]
		).joined(separator: " ").asString
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
