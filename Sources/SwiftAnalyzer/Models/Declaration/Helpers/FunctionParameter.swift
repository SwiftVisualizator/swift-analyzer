//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 11.03.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

/// Function parameter declaration.
/// For example, `_ element: E` and `to storage: Storage` in `func copy(_ element: E, to storage: Storage)`.
public struct FunctionParameter: Equatable, Hashable, Codable {
	
	// MARK: Exposed properties
	
	/// The declaration attributes. For example, `@discardableResult`.
	public let wrappers: [Wrapper]
	
	/// First and extenral parameter.
	/// For example, `nil` and `to` in `func copy(_ element: E, to storage: Storage)`.
	public let externalName: String?
	
	/// Second and internal parameter.
	/// For example, `element` and `storage` in `func copy(_ element: E, to storage: Storage)`.
	public let internalName: String?
	
	/// Parameter type.
	/// For example, `E` and `Storage` in `func copy(_ element: E, to storage: Storage)`.
	public let type: String?
	
	/// Whether a parameter is varadic (contains trailing `...`).
	public let isVaradic: Bool
	
	/// Default argument of the parameter.
	/// For example, `.default` in `func copy(_ element: E, to storage: Storage = .default)`.
	public let defaultArgument: String?
	
	// MARK: Init
	
	/// Creates an instance initialized with the given syntax node.
	init(node: FunctionParameterSyntax) {
		self.wrappers = node.attributes?
			.compactMap({ $0.as(AttributeSyntax.self) })
			.map(Wrapper.init(node:)) ?? []
		self.externalName = node.firstName?.text.trimmed
		self.internalName = node.secondName?.text.trimmed
		self.type = node.type?.description.trimmed
		self.isVaradic = (node.ellipsis != nil)
		self.defaultArgument = node.defaultArgument?.value.description.trimmed
	}

}

// MARK: - CustomStringConvertible

extension FunctionParameter: CustomStringConvertible {
	
	public var description: String {
		var result: String = ""
		result += (
			wrappers.map(\.description) +
			[externalName, internalName].compactMap(\.?.description)
		).joined(separator: " ").asString
		
		if let type {
			result += ": \(type)"
		}
		
		if let defaultArgument {
			result += " = \(defaultArgument)"
		}
		
		return result
	}

}
