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
	
	struct A {
		struct B {
			struct C: Hashable {
				
			}
		}
	}
	
	// MARK: Exposed properties
	
	/// Found declarations.
	private(set) var assembly: DeclarationAssembly = DeclarationAssembly()
	
	private(set) var sourceLocationConverter: SourceLocationConverter?
	
	// MARK: - Init
	
	init(sourceLocationConverter: SourceLocationConverter?) {
		self.sourceLocationConverter = sourceLocationConverter
		super.init(viewMode: .sourceAccurate)
	}
	
	// MARK: Helper methods
	
	private func fileMeta<DeclarationSyntax: DeclSyntaxProtocol>(
		from declaration: DeclarationSyntax
	) -> FileMeta? {
		guard
			let fileName = startLocationIfPossible(from: declaration)?.file
		else {
			return nil
		}
		return FileMeta(name: fileName)
	}
	
	private func locationMeta<DeclarationSyntax: DeclSyntaxProtocol>(
		from declaration: DeclarationSyntax
	) -> LocationMeta? {
		guard
			let startRow = startLocationIfPossible(from: declaration)?.line,
			let endRow = endLocationIfPossible(from: declaration)?.line
		else {
			return nil
		}
		return LocationMeta(
			startRow: startRow,
			endRow: endRow
		)
	}
	
	private func startLocationIfPossible<DeclarationSyntax: DeclSyntaxProtocol>(
		from declaration: DeclarationSyntax
	) -> SourceLocation? {
		guard
			let sourceLocationConverter
		else {
			return nil
		}
		return declaration.startLocation(
			converter: sourceLocationConverter,
			afterLeadingTrivia: true
		)
	}
	
	private func endLocationIfPossible<DeclarationSyntax: DeclSyntaxProtocol>(
		from declaration: DeclarationSyntax
	) -> SourceLocation? {
		guard
			let sourceLocationConverter
		else {
			return nil
		}
		return declaration.endLocation(
			converter: sourceLocationConverter,
			afterTrailingTrivia: false
		)
	}
	
	// MARK: Override
	
	override func visit(_ node: AssociatedtypeDeclSyntax) -> SyntaxVisitorContinueKind {
		var declaration = AssociatedTypeDeclaration(node: node)
		declaration.locationMeta = locationMeta(from: node)
		declaration.fileMeta = fileMeta(from: node)
		assembly.associatedTypeDeclarations.append(declaration)
		return super.visit(node)
	}
	
	override func visit(_ node: TypealiasDeclSyntax) -> SyntaxVisitorContinueKind {
		var declaration = TypealiasDeclaration(node: node)
		declaration.locationMeta = locationMeta(from: node)
		declaration.fileMeta = fileMeta(from: node)
		assembly.typealiasDeclarations.append(declaration)
		return super.visit(node)
	}
	
	override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
		var declaration = FunctionDeclaration(node: node)
		declaration.locationMeta = locationMeta(from: node)
		declaration.fileMeta = fileMeta(from: node)
		assembly.functionDeclarations.append(declaration)
		return super.visit(node)
	}
	
	override func visit(_ node: ExtensionDeclSyntax) -> SyntaxVisitorContinueKind {
		var declaration = ExtensionDeclaration(node: node)
		declaration.locationMeta = locationMeta(from: node)
		declaration.fileMeta = fileMeta(from: node)
		assembly.extensionDeclarations.append(declaration)
		return super.visit(node)
	}
	
	override func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
		var declaration = ImportDeclaration(node: node)
		declaration.locationMeta = locationMeta(from: node)
		declaration.fileMeta = fileMeta(from: node)
		assembly.importDeclarations.append(declaration)
		return super.visit(node)
	}
	
	override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
		var declaration = EnumDeclaration(node: node)
		declaration.locationMeta = locationMeta(from: node)
		declaration.fileMeta = fileMeta(from: node)
		assembly.enumDeclarations.append(declaration)
		return super.visit(node)
	}
	
	override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
		var declaration = ClassDeclaration(node: node)
		declaration.locationMeta = locationMeta(from: node)
		declaration.fileMeta = fileMeta(from: node)
		assembly.classDeclarations.append(declaration)
		return super.visit(node)
	}
	
	override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
		var declaration = ProtocolDeclaration(node: node)
		declaration.locationMeta = locationMeta(from: node)
		declaration.fileMeta = fileMeta(from: node)
		assembly.protocolDeclarations.append(declaration)
		return super.visit(node)
	}
	
	override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
		var declaration = StructDeclaration(node: node)
		declaration.locationMeta = locationMeta(from: node)
		declaration.fileMeta = fileMeta(from: node)
		assembly.structDeclarations.append(declaration)
		return super.visit(node)
	}
	
	override func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
		node.bindings.forEach { binding in
			if var declaration = VariableDeclaration(node: binding) {
				declaration.locationMeta = locationMeta(from: node)
				declaration.fileMeta = fileMeta(from: node)
				assembly.variableDeclarations.append(declaration)
			}
		}
		return super.visit(node)
	}
	
}
