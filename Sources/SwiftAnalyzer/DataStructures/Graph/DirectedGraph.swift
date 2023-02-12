//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 08.02.2023.
//

import Foundation

// MARK: - Graph

class DirectedGraph<Content: Hashable> {

	// MARK: Typealiases

	typealias V = Vertex<Content>

	typealias E = DirectedEdge<Content>

	// MARK: Private properties

	/// Graph storage.
	private var adjacencyList: [V: Set<V>] = [:]

	// MARK: Exposed methods
	
	/// All graph vertices.
	func vertices() -> Set<V> {
		return Set(adjacencyList.keys)
	}
	
	/// Vertices without incoming edges.
	func rootVertices() throws -> Set<V> {
		return try invertedCopy().leafVertices()
	}
	
	/// Vertices without outgoing edges.
	func leafVertices() -> Set<V> {
		return Set(adjacencyList.filter(\.value.isEmpty).keys)
	}
	
	/// Returns a copy of this graph, but with having directed edges **inverted**.
	func invertedCopy() throws -> DirectedGraph<Content> {
		let invertedGraph: DirectedGraph<Content> = DirectedGraph()
		try adjacencyList.forEach { vertex, neighbourhood in
			try neighbourhood.forEach { neighbourVertex in
				let invertedEdge: DirectedEdge<Content> = DirectedEdge(
					from: neighbourVertex,
					to: vertex
				)
				try invertedGraph.insert(edge: invertedEdge)
			}
		}
		return invertedGraph
	}

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
		guard
			!contains(vertex: vertex)
		else {
			throw GraphError.vertexIsAlreadyInGraph
		}
		adjacencyList[vertex] = []
	}
	
	/// `O(1)`. Inserts a content (building a vertex from it) into the graph.
	///
	/// - Throws: `GraphError.vertexIsAlreadyInGraph` - if a vertex is already present.
	func insert(content: Content) throws {
		let vertex: V = Vertex(content: content)
		
		guard
			!contains(vertex: vertex)
		else {
			throw GraphError.vertexIsAlreadyInGraph
		}
		adjacencyList[vertex] = []
	}
	
	/// Inserts a content (building a vertex from it) array into the graph.
	///
	/// - Throws: `GraphError.vertexIsAlreadyInGraph` - if any vertex is already present.
	func insert(contents: [Content]) throws {
		try contents.forEach(insert(content:))
	}

	/// `O(1)`. Inserts an edge into the graph.
	///
	/// - Throws: `GraphError.edgeIsAlreadyInGraph` - if an edge is already present.
	func insert(edge: E) throws {
		guard
			!contains(edge: edge)
		else {
			throw GraphError.edgeIsAlreadyInGraph
		}
		try? insert(vertex: edge.from)
		try? insert(vertex: edge.to)
		adjacencyList[edge.from]?.insert(edge.to)
	}
	
	/// `O(1)`. Inserts an edge into the graph.
	///
	/// - Throws: `GraphError.edgeIsAlreadyInGraph` - if an edge is already present.
	func insert(
		edgeFrom fromContent: Content,
		to toContent: Content
	) throws {
		try insert(edge: DirectedEdge(
			from: Vertex(content: fromContent),
			to: Vertex(content: toContent)
		))
	}
	
	/// `O(1)`.  Returns the neighbourhood of a vertex.
	///
	/// - Throws: `GraphError.noSuchVertex` - if a vertex is not present in the graph.
	func neighbourhood(of vertex: V) throws -> Set<V> {
		guard
			contains(vertex: vertex)
		else {
			throw GraphError.noSuchVertex
		}
		return adjacencyList[vertex] ?? []
	}

	
	/// `O(|E| + |V|)`.  Performes DFS from a vertex. Returns the set of visited vertices.67
	///
	/// - Throws: `GraphError.noSuchVertex` - if a vertex is not present in the graph.
	func dfs(startingFrom startVertex: V) throws -> Set<V> {
		guard
			contains(vertex: startVertex)
		else {
			throw GraphError.noSuchVertex
		}

		var visitedVerices: Set<V> = []
		let stack: Stack<V> = Stack([startVertex])

		while !stack.isEmpty {
			guard
				let vertex = stack.pop(),
				!visitedVerices.contains(vertex)
			else {
				continue
			}

			visitedVerices.insert(vertex)

			adjacencyList[vertex]?
				.subtracting(visitedVerices)
				.forEach(stack.push(_:))
		}

		return visitedVerices
	}

}
