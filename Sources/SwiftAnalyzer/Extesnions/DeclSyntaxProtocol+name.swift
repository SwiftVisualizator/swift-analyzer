//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 12.05.2023.
//

import Foundation
import SwiftSyntax

extension DeclSyntaxProtocol {
	
	internal var declarationName: String? {
		if let declSyntax = self as? StructDeclSyntax {
			return declSyntax.identifier.text
		} else if let declSyntax = self as? ClassDeclSyntax {
			return declSyntax.identifier.text
		} else if let declSyntax = self as? ActorDeclSyntax {
			return declSyntax.identifier.text
		} else if let declSyntax = self as? ExtensionDeclSyntax {
			return declSyntax.extendedType.description.trimmed
		} else if let declSyntax = self as? EnumDeclaration {
			return declSyntax.name
		} else  {
			return nil
		}
	}
	
}
