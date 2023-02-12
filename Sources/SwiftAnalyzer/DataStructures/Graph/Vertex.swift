//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 07.02.2023.
//

import Foundation

// MARK: - Vertex

/// Graph vertex abstraction.
struct Vertex<Content: Hashable> {
	
	// MARK: Exposed properties
	
	/// Unique vertex index for the whole graph.
	/// Does **not** participate in `Equatable` and `Hashable` conformance.
	private(set) var index: UInt64?
	
	/// Vertex wrapped content.
	private(set) var content: Content
	
	// MARK: Init
	
	/// Creates an instance memberwise.
	init(content: Content) {
		self.index = nil
		self.content = content
	}
	
	// MARK: Exposed methods

	/// Change vertex index.
	mutating func update(index: UInt64?) {
		self.index = index
	}
	
}

// MARK: - Equatable

extension Vertex: Equatable {
	
	static func == (lhs: Vertex<Content>, rhs: Vertex<Content>) -> Bool {
		return lhs.content == rhs.content
	}
	
}

// MARK: - Hashable

extension Vertex: Hashable {
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(content)
	}
	
}
