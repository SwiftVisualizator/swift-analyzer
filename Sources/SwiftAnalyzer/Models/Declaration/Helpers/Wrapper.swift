//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 06.02.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

/// Helper structure. Wrapper or attribute with extra information about a declaration.
///
/// For example, `@discardableResult`, `@Published`, `@available(*, unavailable)`.
public struct Wrapper: Equatable, Hashable, Codable {
	
	// MARK: Exposed properties
	
	/// String without leading *@* and without a list of parameters,
	/// for instance, *available*, `@available(*, unavailable)`
	public internal(set) var name: String
	
	/// Ordered list of wrapper parameters like
	/// `(*, unavailable)` in `@available(*, unavailable)`
	public internal(set) var parameters: [Wrapper.Parameter]
	
	// MARK: Init
	
	/// Creates an instance memberwise.
	init(name: String, parameters: [Wrapper.Parameter]) {
		self.name = name
		self.parameters = parameters
	}
	
	/// Creates an instance from SwiftSyntax model.
	init(node: AttributeSyntax) {
		self.name = node.attributeName.text.trimmed
		self.parameters = node.argument?.description
			.split(separator: ",")
			.map({ $0.split(separator: ":", maxSplits: 1) })
			.compactMap({ components in
				if components.count == 2, let key = components.first, let value = components.last {
					return Parameter(
						key: String(key).trimmed,
						value: String(value).trimmed
					)
				} else if components.count == 1, let value = components.first {
					return Parameter(
						key: nil,
						value: String(value).trimmed
					)
				} else {
					return nil
				}
			}) ?? []
	}
	
}

// MARK: - Attribute

extension Wrapper {
	
	public struct Parameter: Equatable, Hashable, Codable, CustomStringConvertible {
		
		// MARK: Exposed properties
		
		public var description: String {
			var result: String = ""
			if let key {
				result += key
				result += ": "
			}
			result += value
			return result
		}
		
		/// Optional key.
		public let key: String?
		
		/// Value.
		public let value: String
		
	}
	
}

// MARK: - CustomStringConvertible

extension Wrapper: CustomStringConvertible {
	
	public var description: String {
		var result: String = ""
		result += "@"
		result += name
		if !parameters.isEmpty {
			result += "("
			result += parameters.map(\.description).joined(separator: ", ")
			result += ")"
		}
		return result
	}
	
}
