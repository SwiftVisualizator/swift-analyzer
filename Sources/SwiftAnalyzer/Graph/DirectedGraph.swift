//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 08.02.2023.
//

import Foundation

// MARK: - Graph

final class DirectedGraph<Content: Hashable> {
	
	// MARK: Typealiases
	
	typealias V = Vertex<Content>
	
	typealias E = DirectedEdge<Content>
	
	// MARK: Private properties
	
	/// Graph storage.
	private var adjacencyList: [V: Set<V>] = [:]
	
	// MARK: Exposed methods
	
	/// `O(1)`. Checks that a vertex is in the graph.
	func contains(vertex: V) -> Bool {
		return adjacencyList.keys.contains(vertex)
	}
	
	/// `O(1)`. Checks that an edge is in the graph.
	func contains(edge: E) -> Bool  {
		return (adjacencyList[edge.from]?.contains(edge.to) == true)
	}
	
	/// `O(1)`. Inserts a vertex into the graph.
	///
	/// - Throws: `GraphError.vertexIsAlreadyInGraph` - if a vertex is already present.
	func insert(vertex: V) throws {
		if contains(vertex: vertex) {
			throw GraphError.vertexIsAlreadyInGraph
		} else {
			adjacencyList[vertex] = []
		}
	}
	
	/// `O(1)`. Inserts an edge into the graph.
	///
	/// - Throws: `GraphError.edgeIsAlreadyInGraph` - if an edge is already present.
	func insert(edge: E) throws {
		if contains(edge: edge) {
			throw GraphError.vertexIsAlreadyInGraph
		} else {
			try? insert(vertex: edge.from)
			try? insert(vertex: edge.to)
			adjacencyList[edge.from]?.insert(edge.to)
		}
	}

}
