//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 11.03.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

/// An enumeration case declaration.
public struct CaseDeclaration: Declaration, Wrappable, Modifiable, Keywordable, Namable {
	
	// MARK: Exposed properties
	
	public let identifier: String = UUID().uuidString
	
	public let wrappers: [Wrapper]
	
	public let modifiers: [Modifier]
	
	public let keyword: String
	
	public let name: String
	
	/// Enum case raw value if present.
	public let rawValue: String?
	
	// MARK: Init
	
	/// Creates an instance initialized with the given syntax node.
	init?(node: EnumCaseElementSyntax) {
		guard
			let parent = node.firstDeclarationParent as? EnumCaseDeclSyntax
		else {
			return nil
		}
		self.wrappers = parent.attributes?
			.compactMap({ $0.as(AttributeSyntax.self) })
			.map(Wrapper.init(node:)) ?? []
		self.modifiers = parent.modifiers?
			.map(Modifier.init(node:)) ?? []
		self.keyword = parent.caseKeyword.text.trimmed
		self.name = node.identifier.text.trimmed
		self.rawValue = node.rawValue?.value.description.trimmed
	}

}

// MARK: - CustomStringConvertible

extension CaseDeclaration: CustomStringConvertible {
	
	public var description: String {
		var result: String = ""
		result += (
			wrappers.map(\.description) +
			modifiers.map(\.description) +
			[keyword] +
			[name]
		).joined(separator: " ").asString
		if let rawValue {
			result += " = \(rawValue)"
		}
		return result
	}
	
}
