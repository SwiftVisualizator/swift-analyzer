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
	
	/// Found class declarations.
	private(set) var classDeclarations: [ClassDeclaration] = []
	
	/// Found protocol declarations.
	private(set) var protocolDeclarations: [ProtocolDeclaration] = []
	
	/// Found structure declarations.
	private(set) var structureDeclarations: [StructDeclaration] = []
	
	/// Found variable declarations.
	private(set) var variableDeclarations: [VariableDeclaration] = []
	
	// MARK: Overrride
	
	override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
		classDeclarations.append(ClassDeclaration(node: node))
		return super.visit(node)
	}
	
	override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
		protocolDeclarations.append(ProtocolDeclaration(node: node))
		return super.visit(node)
	}
	
	override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
		structureDeclarations.append(StructDeclaration(node: node))
		return super.visit(node)
	}
	
	override func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
		variableDeclarations.append(contentsOf: node.bindings.compactMap(VariableDeclaration.init(node:)))
		return super.visit(node)
	}
	
}
