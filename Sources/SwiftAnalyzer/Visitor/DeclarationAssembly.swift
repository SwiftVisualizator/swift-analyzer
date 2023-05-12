//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 07.02.2023.
//

import Foundation

// MARK: - Assembly

/// Stores all declarations found in some scope, for example, project or file.
public final class DeclarationAssembly {
	
	// MARK: Exposed properties
	
	/// Found import declarations.
	public internal(set) var importDeclarations: [ImportDeclaration] = []
	
	/// Found typealias declarations.
	public internal(set) var typealiasDeclarations: [TypealiasDeclaration] = []
	
	/// Found associated type declarations.
	public internal(set) var associatedTypeDeclarations: [AssociatedTypeDeclaration] = []
	
	/// Found enum declarations.
	public internal(set) var enumDeclarations: [EnumDeclaration] = []
	
	/// Found actor declarations.
	public internal(set) var actorDeclarations: [ActorDeclaration] = []
	
	/// Found class declarations.
	public internal(set) var classDeclarations: [ClassDeclaration] = []
	
	/// Found function declarations.
	public internal(set) var functionDeclarations: [FunctionDeclaration] = []
	
	/// Found extension declarations.
	public internal(set) var extensionDeclarations: [ExtensionDeclaration] = []
	
	/// Found protocol declarations.
	public internal(set) var protocolDeclarations: [ProtocolDeclaration] = []
	
	/// Found structure declarations.
	public internal(set) var structDeclarations: [StructDeclaration] = []
	
	/// Found variable declarations.
	public internal(set) var variableDeclarations: [VariableDeclaration] = []
	
	// MARK: Init
	
	internal init() {
		
	}
	
	// MARK: Exposed methods
	
	/// Adds(in-place) content of other assembly to this one.
	public func merge(_ other: DeclarationAssembly) {
		self.enumDeclarations += other.enumDeclarations
		self.actorDeclarations += other.actorDeclarations
		self.classDeclarations += other.classDeclarations
		self.importDeclarations += other.importDeclarations
		self.protocolDeclarations += other.protocolDeclarations
		self.variableDeclarations += other.variableDeclarations
		self.functionDeclarations += other.functionDeclarations
		self.extensionDeclarations += other.extensionDeclarations
		self.structDeclarations += other.structDeclarations
		self.typealiasDeclarations += other.typealiasDeclarations
		self.associatedTypeDeclarations += other.associatedTypeDeclarations
	}

}
