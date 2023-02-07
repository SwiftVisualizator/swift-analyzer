//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 06.02.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Visitor

/// SwiftSyntax visitor subclass that stores visited node models when visiting them.
/// It stores declarations like classes, protocols, extensions etc
final class DeclarationVisitor: SyntaxVisitor {
	
	// MARK: Exposed properties
	
	/// Found declarations.
	private(set) var assembly: DeclarationAssembly = DeclarationAssembly()
	
	// MARK: Overrride
	
	override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
		assembly.classDeclarations.append(ClassDeclaration(node: node))
		return super.visit(node)
	}
	
	override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
		assembly.protocolDeclarations.append(ProtocolDeclaration(node: node))
		return super.visit(node)
	}
	
	override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
		assembly.structureDeclarations.append(StructDeclaration(node: node))
		return super.visit(node)
	}
	
	override func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
		assembly.variableDeclarations.append(
			contentsOf: node.bindings.compactMap(VariableDeclaration.init(node:))
		)
		return super.visit(node)
	}
	
}
