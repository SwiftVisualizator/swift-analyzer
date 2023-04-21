//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 08.02.2023.
//

import Foundation

// MARK: - Analyzer

final class DependencyAnalyzer {
	
	// MARK: Private properties
	
	private let directedGraph: DirectedGraph<DeclarationDependencyMemeberKind> = DirectedGraph()

	// MARK: Init

	init(declarations: DeclarationAssembly) throws {
		//
		// Insert vertices
		//
		var dependencyMemberKinds: [DeclarationDependencyMemeberKind] = []
		dependencyMemberKinds += declarations.protocolDeclarations
			.map(DeclarationDependencyMemeberKind.protocol)
		dependencyMemberKinds += declarations.classDeclarations
			.map(DeclarationDependencyMemeberKind.class)
		dependencyMemberKinds += declarations.structDeclarations
			.map(DeclarationDependencyMemeberKind.struct)
		dependencyMemberKinds += declarations.enumDeclarations
			.map(DeclarationDependencyMemeberKind.enum)
		dependencyMemberKinds += declarations.extensionDeclarations
			.map(DeclarationDependencyMemeberKind.extension)
		try directedGraph.insert(contents: dependencyMemberKinds)
		//
		// Insert edges
		//
		try dependencyMemberKinds.forEach { memberKind in
			try memberKind.declarationInheritances
				.compactMap { parentName in
					if let parentMember = dependencyMemberKinds.first(where: {
						$0.declarationName == parentName
					}) {
						return parentMember
					} else {
						return .unknown(declarationName: parentName)
					}
				}
				.forEach { parentMemberKind in
					try directedGraph.insert(
						edgeFrom: parentMemberKind,
						to: memberKind
					)
				}
		}
	}
	
	// MARK: Exposed methods
	
	func rootDeclarationDependencyMembers() throws -> Set<DeclarationDependencyMember> {
		let members = try directedGraph
			.rootVertices()
			.map(dependencyMember(from:))
		return Set(members)
	}
	
	// MARK: Private methods
	
	private func dependencyMember(
		from vertex: Vertex<DeclarationDependencyMemeberKind>
	) throws -> DeclarationDependencyMember {
		var member = DeclarationDependencyMember(kind: vertex.content)
		try directedGraph
			.neighbourhood(of: vertex)
			.map(dependencyMember(from:))
			.forEach { neighbour in
				try member.addChild(neighbour)
			}
		return member
	}

}
