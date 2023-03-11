//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 11.03.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

/// Generic requirement declaration. For example, `Element: Codable` and `Identifier == UUID`
/// from `where Element: Codable, Identifier == UUID`.
public struct GenericRequirement: Equatable, Hashable, Codable {
	
	// MARK: Exposed properties
	
	/// Type before the operator.
	public internal(set) var leadingType: String
	
	/// The relation operator.
	public internal(set) var relation: Relation
	
	/// Type after the operator.
	public internal(set) var trailingType: String
	
	// MARK: Init
	
	/// Creates an instance from SwiftSyntax model.
	init?(node: GenericRequirementSyntax) {
		if let node = SameTypeRequirementSyntax(node.body) {
			self.init(node: node)
		} else if let node = ConformanceRequirementSyntax(node.body) {
			self.init(node: node)
		} else {
			return nil
		}
	}
	
	/// Creates an instance from SwiftSyntax model.
	private init(node: SameTypeRequirementSyntax) {
		self.relation = .equals
		self.leadingType = node.leftTypeIdentifier.description.trimmed
		self.trailingType = node.rightTypeIdentifier.description.trimmed
	}
	
	/// Creates an instance from SwiftSyntax model.
	private init(node: ConformanceRequirementSyntax) {
		self.relation = .conforms
		self.leadingType = node.leftTypeIdentifier.description.trimmed
		self.trailingType = node.rightTypeIdentifier.description.trimmed
	}
	
}

// MARK: - Relation

extension GenericRequirement {
	
	/// Relation operator in the generic requirement.
	public enum Relation: String, Equatable, Hashable, Codable {
		
		/// Leading type (A) is equal to trailing type (B). For example, `A == B`.
		case equals
		
		/// Leading type (A) conforms to trailing type (B). For example, `A: B`.
		case conforms
		
	}
	
}

// MARK: - CustomStringConvertible

extension GenericRequirement: CustomStringConvertible {
	
	public var description: String {
		switch relation {
		case .equals:
			return "\(leadingType) == \(trailingType)"
		case .conforms:
			return "\(leadingType): \(trailingType)"
		}
	}
	
}
