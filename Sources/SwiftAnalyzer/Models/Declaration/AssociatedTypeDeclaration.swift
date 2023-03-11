//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 11.03.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

/// An associated type declaration.
public struct AssociatedTypeDeclaration: Declaration, Wrappable, Modifiable, Keywordable, Namable {
	
	// MARK: Exposed properties
	
	public let identifier: String = UUID().uuidString
	
	public let wrappers: [Wrapper]
	
	public let modifiers: [Modifier]
	
	public let keyword: String
	
	public let name: String
	
	// MARK: Init
	
	/// Creates an instance from SwiftSyntax model.
	init(node: AssociatedtypeDeclSyntax) {
		self.wrappers = node.attributes?
			.compactMap { $0.as(AttributeSyntax.self) }
			.map(Wrapper.init(node:)) ?? []
		self.modifiers = node.modifiers?
			.map(Modifier.init(node:)) ?? []
		self.keyword = node.associatedtypeKeyword.text.trimmed
		self.name = node.identifier.text.trimmed
	}
	
}

// MARK: - CustomStringConvertible

extension AssociatedTypeDeclaration: CustomStringConvertible {
	
	public var description: String {
		var result: String = ""
		result += (
			wrappers.map(\.description) +
			modifiers.map(\.description) +
			[keyword] +
			[name]
		).joined(separator: " ").asString
		return result
	}
	
}
