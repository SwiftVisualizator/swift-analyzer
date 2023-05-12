//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 08.02.2023.
//

import Foundation

// MARK: - Model

public struct DeclarationDependencyMember: Hashable {
	
	// MARK: Exposed properties
	
	/// Wrapped declaration.
	public let kind: DeclarationDependencyMemeberKind
	
	/// Declaration name.
	public var name: String {
		return kind.declarationName
	}
	
	/// Child declarations.
	///
	/// For example, in `class ProfileResponse: Decodable`,
	/// the class declaration `ProfileResponse` is a child of `Decodable` protocol
	public internal(set) var childs: [DeclarationDependencyMember] = []
	
	// MARK: Init
	
	init(kind memberKind: DeclarationDependencyMemeberKind) {
		self.kind = memberKind
	}
	
	init(actor declaration: ActorDeclaration) {
		self.kind = .actor(declaration)
	}
	
	init(class declaration: ClassDeclaration) {
		self.kind = .class(declaration)
	}
	
	init(struct declaration: StructDeclaration) {
		self.kind = .struct(declaration)
	}
	
	init(protocol declaration: ProtocolDeclaration) {
		self.kind = .protocol(declaration)
	}
	
	init(enum declaration: EnumDeclaration) {
		self.kind = .enum(declaration)
	}
	
	// MARK: Exposed methods
	
	func canHaveChild(_ other: DeclarationDependencyMember) -> Bool {
		return self.kind.canHaveChild(other.kind)
	}
	
	mutating func addChild(_ other: DeclarationDependencyMember) throws {
		guard
			canHaveChild(other)
		else {
			throw DependencyError.cannotHaveChild(member: self, child: other)
		}
		childs.append(other)
	}
	
}

// MARK: - CustomStringConvertible

extension DeclarationDependencyMember: CustomStringConvertible {
	
	public var description: String {
		return name
	}
	
}
