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
/// It stores declarations like classes, protocols, extensions etc.
final class DeclarationVisitor: SyntaxVisitor {
	
	// MARK: Exposed properties
	
	/// Found declarations.
	private(set) var assembly: DeclarationAssembly = DeclarationAssembly()
	
	// MARK: Override
	
	override func visit(_ node: AssociatedtypeDeclSyntax) -> SyntaxVisitorContinueKind {
		assembly.associatedTypeDeclarations.append(AssociatedTypeDeclaration(node: node))
		return super.visit(node)
	}
	
	override func visit(_ node: TypealiasDeclSyntax) -> SyntaxVisitorContinueKind {
		assembly.typealiasDeclarations.append(TypealiasDeclaration(node: node))
		return super.visit(node)
	}
	
	override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
		assembly.functionDeclarations.append(FunctionDeclaration(node: node))
		return super.visit(node)
	}
	
	override func visit(_ node: ExtensionDeclSyntax) -> SyntaxVisitorContinueKind {
		assembly.extensionDeclarations.append(ExtensionDeclaration(node: node))
		return super.visit(node)
	}
	
	override func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
		assembly.importDeclarations.append(ImportDeclaration(node: node))
		return super.visit(node)
	}
	
	override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
		assembly.enumDeclarations.append(EnumDeclaration(node: node))
		return super.visit(node)
	}
	
	override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
		assembly.classDeclarations.append(ClassDeclaration(node: node))
		return super.visit(node)
	}
	
	override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
		assembly.protocolDeclarations.append(ProtocolDeclaration(node: node))
		return super.visit(node)
	}
	
	override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
		assembly.structDeclarations.append(StructDeclaration(node: node))
		return super.visit(node)
	}
	
	override func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
		assembly.variableDeclarations.append(
			contentsOf: node.bindings.compactMap(VariableDeclaration.init(node:))
		)
		return super.visit(node)
	}
	
}
