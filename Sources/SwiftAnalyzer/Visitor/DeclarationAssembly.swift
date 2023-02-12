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
	
	/// Found class declarations.
	public internal(set) var classDeclarations: [ClassDeclaration] = []
	
	/// Found protocol declarations.
	public internal(set) var protocolDeclarations: [ProtocolDeclaration] = []
	
	/// Found structure declarations.
	public internal(set) var structureDeclarations: [StructDeclaration] = []
	
	/// Found variable declarations.
	public internal(set) var variableDeclarations: [VariableDeclaration] = []
	
	// MARK: Init
	
	init() {
		
	}
	
	// MARK: Exposed methods
	
	/// Adds(in-place) content of other assembly to this one.
	public func merge(_ other: DeclarationAssembly) {
		self.classDeclarations += other.classDeclarations
		self.protocolDeclarations += other.protocolDeclarations
		self.structureDeclarations += other.structureDeclarations
		self.variableDeclarations += other.variableDeclarations
	}

}
