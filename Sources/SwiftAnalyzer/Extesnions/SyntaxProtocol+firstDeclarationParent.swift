//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 06.02.2023.
//

import Foundation
import SwiftSyntax

extension SyntaxProtocol {
	
	/// Returns a "declaration context" in which a node is located.
	var firstDeclarationParent: DeclSyntaxProtocol? {
		for case let node? in sequence(first: parent, next: { $0?.parent }) {
			if let declaration = node.asProtocol(DeclSyntaxProtocol.self) {
				return declaration
			}
		}
		return nil
	}
	
}
