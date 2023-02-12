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
public struct VariableDeclaration: Declaration, Namable, Keywordable, Wrappable, Modifiable {
	
	// MARK: - Exposed properties
	
	public let identifier: String = UUID().uuidString
	
	public let wrappers: [Wrapper]
	
	public let modifiers: [Modifier]
	
	public let keyword: String
	
	public let name: String
	
	/// Variable type if present.
	public let type: String?
	
	/// Initial value if present.
	public let initialValue: String?
	
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
	
	public struct Accessor: Equatable, Hashable {
		
		// MARK: Exposed types
		
		public enum AccessorType: String, Equatable, Hashable {
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
