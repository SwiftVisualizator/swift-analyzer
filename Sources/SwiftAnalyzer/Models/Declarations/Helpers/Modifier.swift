//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 06.02.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

/// Declaration modifier. For example, `private(set)`, `open`, `nonmutating`, `static`.
public struct Modifier {
	
	// MARK: Exposed properties
	
	/// Modifier name, like `public` or `nonisolated`.
	public internal(set) var name: String
	
	/// Extra name in parenthesis, like `set` from `private(set)`.
	public internal(set) var extraName: String?
	
	// MARK: Init
	
	/// Creates an instance from SwiftSyntax model.
	init(node: DeclModifierSyntax) {
		self.name = node.name.text.trimmed
		self.extraName = node.detail?.description
	}
	
}

// MARK: - CustomStringConvertible

extension Modifier: CustomStringConvertible {
	
	public var description: String {
		var result: String = ""
		result += name
		if let extraName {
			result += "(\(extraName))"
		}
		return result
	}
	
}
