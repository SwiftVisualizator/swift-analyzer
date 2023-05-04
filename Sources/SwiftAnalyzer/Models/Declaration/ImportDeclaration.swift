//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 11.03.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

/// An import declaration.
public struct ImportDeclaration:
	Declaration,
	Keywordable,
	Wrappable,
	Modifiable,
	Namable,
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
	
	public var name: String {
		return pathComponents.joined(separator: ".")
	}
	
	/// Import path components. For example, `Foundation.NSArray`.
	public let pathComponents: [String]
	
	// MARK: Init

	/// Creates an instance from SwiftSyntax model.
	init(node: ImportDeclSyntax) {
		self.wrappers = node.attributes?
			.compactMap({ $0.as(AttributeSyntax.self) })
			.map(Wrapper.init(node:)) ?? []
		self.modifiers = node.modifiers?
			.map(Modifier.init(node:)) ?? []
		self.keyword = node.importTok.text.trimmed
		self.pathComponents = node.path.tokens(viewMode: .sourceAccurate)
			.filter({ $0.tokenKind != .period })
			.map(\.text.trimmed)
		self.docStringMeta = DocStringMeta(node: node)
	}
	
}

// MARK: - CustomStringConvertible

extension ImportDeclaration: CustomStringConvertible {
	
	public var description: String {
		var result: String = ""
		result += (
			wrappers.map(\.description) +
			modifiers.map(\.description) +
			[keyword, name]
		).joined(separator: " ").asString
		return result
	}
	
}
