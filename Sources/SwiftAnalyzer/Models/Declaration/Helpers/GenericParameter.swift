//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 06.02.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

/// Generic parameter declaration. For example, `Header` and `Body: Codalbe`
/// from `<Headers, Body: Codable>`.
public struct GenericParameter: Equatable, Hashable {

	// MARK: - Exposed proeprties

	/// Generic parameter name.
	public internal(set) var name: String

	/// Generic parameter constraint type.
	public internal(set) var constraintType: String?

	// MARK: - Init
	
	/// Creates an instance memberwise.
	init(name: String, constraintType: String? = nil) {
		self.name = name
		self.constraintType = constraintType
	}
	
	/// Creates an instance from SwiftSyntax model.
	init(node: GenericParameterSyntax) {
		self.name = node.name.text.trimmed
		self.constraintType = node.inheritedType?.description
	}

}

// MARK: - CustomStringConvertible

extension GenericParameter: CustomStringConvertible {

	public var description: String {
		var result: String = ""
		result += name
		if let constraintType {
			result += ": "
			result += constraintType
		}
		return result
	}

}
