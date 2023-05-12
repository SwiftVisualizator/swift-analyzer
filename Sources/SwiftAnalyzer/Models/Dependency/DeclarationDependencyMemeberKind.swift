//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 08.02.2023.
//

import Foundation

// MARK: - Kind

public enum DeclarationDependencyMemeberKind: Equatable, Hashable {
	
	// MARK: Cases
	
	case unknown(declarationName: String)
	
	case `enum`(EnumDeclaration)
	
	case `actor`(ActorDeclaration)
	
	case `class`(ClassDeclaration)
	
	case `struct`(StructDeclaration)
	
	case `protocol`(ProtocolDeclaration)
	
	case `extension`(ExtensionDeclaration)
	
	// MARK: Exposed properties
	
	/// Wrapped declaration name.
	public var declarationName: String {
		switch self {
		case let .unknown(declarationName: declarationName):
			return declarationName
		case let .enum(declaration):
			return declaration.name
		case let .actor(declaration):
			return declaration.name
		case let .class(declaration):
			return declaration.name
		case let .struct(declaration):
			return declaration.name
		case let .protocol(declaration):
			return declaration.name
		case let .extension(declaration):
			return "Extension of \(declaration.extendedType)"
		}
	}
	
	/// Wrapped declaration inheritances.
	public var declarationInheritances: [String] {
		switch self {
		case .unknown:
			return []
		case let .enum(declaration):
			return declaration.inheritances
		case let .actor(declaration):
			return declaration.inheritances
		case let .class(declaration):
			return declaration.inheritances
		case let .struct(declaration):
			return declaration.inheritances
		case let .protocol(declaration):
			return declaration.inheritances
		case let .extension(declaration):
			return declaration.inheritances
		}
	}
	
	// MARK: Exposed methods
	
	func canHaveParent(_ parent: DeclarationDependencyMemeberKind) -> Bool {
		switch (self, parent) {
		case (_, .unknown):
			return true
		case (_, .protocol):
			return true
		case (.class, .class):
			return true
		default:
			return false
		}
	}
	
	func canHaveChild(_ child: DeclarationDependencyMemeberKind) -> Bool {
		return child.canHaveParent(self)
	}
	
}
