//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 06.02.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

/// Variable(including top-level) declaration
public struct VariableDeclaration: Declaration {
	
	// MARK: - Exposed properties
	
	/// Declaration list(ordered) of wrappers. For example, `@main`, `@available(iOS 13, *)`.
	public internal(set) var wrappers: [Wrapper]
	
	/// Declaration modifiers. For exmaple, `public`, `open`.
	public internal(set) var modifiers: [Modifier]
	
	/// Static keyword of the declaration. Can be *let* or *var*.
	public internal(set) var keyword: String
	
	/// Variable name.
	public internal(set) var name: String
	
	/// Variable type if present.
	public internal(set) var type: String?
	
	/// Initial value if present.
	public internal(set) var initialValue: String?
	
	/// The variable accessors.
	public let accessors: [Accessor]
	
	// MARK: Init
	
	/// Creates an instance memberwise.
	init(
		wrappers: [Wrapper],
		modifiers: [Modifier],
		keyword: String,
		name: String,
		type: String? = nil,
		initialValue: String? = nil,
		accessors: [Accessor]
	) {
		self.wrappers = wrappers
		self.modifiers = modifiers
		self.keyword = keyword
		self.name = name
		self.type = type
		self.initialValue = initialValue
		self.accessors = accessors
	}
	
	/// Creates an instance from SwiftSyntax model.
	init?(node: PatternBindingSyntax) {
		guard
			let parent = node.firstDeclarationParent as? VariableDeclSyntax
		else {
			return nil
		}
		self.wrappers = parent.attributes?
			.compactMap{ $0.as(AttributeSyntax.self) }
			.map(Wrapper.init(node:)) ?? []
		self.modifiers = parent.modifiers?
			.map(Modifier.init(node:)) ?? []
		self.accessors = node.accessor?.as(AccessorBlockSyntax.self)?.accessors
			.compactMap(Accessor.init(node:)) ?? []
		self.keyword = parent.letOrVarKeyword.text.trimmed
		self.name = node.pattern.description.trimmed
		self.type = node.typeAnnotation?.type.description.trimmed
		self.initialValue = node.initializer?.value.description.trimmed
	}
	
}

// MARK: - Accessor

extension VariableDeclaration {
	
	public struct Accessor {
		
		// MARK: Exposed types
		
		public enum AccessorType: String {
			case getter = "get"
			case setter = "set"
		}
		
		// MARK: Exposed properties
		
		public let wrappers: [Wrapper]
		
		public let type: AccessorType?
		
		public let modifier: Modifier?
		
		// MARK: Init
		
		init?(node: AccessorDeclSyntax) {
			let rawValue: String = node.accessorKind.text.trimmed
			if rawValue.isEmpty {
				self.type = nil
			} else if let type = AccessorType(rawValue: rawValue) {
				self.type = type
			} else {
				return nil
			}
			self.wrappers = node.attributes?
				.compactMap{ $0.as(AttributeSyntax.self) }
				.map(Wrapper.init(node:)) ?? []
			self.modifier = node.modifier.map(Modifier.init(node:))
		}
		
	}
	
}

// MARK: - CustomStringConvertible

extension VariableDeclaration: CustomStringConvertible {
	
	public var description: String {
		if let type, let initialValue {
			return "\(keyword) \(name): \(type) = \(initialValue)"
		} else if let type {
			return "\(keyword) \(name): \(type)"
		} else if let initialValue {
			return "\(keyword) \(name) = \(initialValue)"
		} else {
			return "\(keyword) \(name)"
		}
	}
	
}
