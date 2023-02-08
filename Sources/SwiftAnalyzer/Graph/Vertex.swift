//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 07.02.2023.
//

import Foundation

// MARK: - Vertex

/// Graph vertex abstraction.
struct Vertex<Content: Hashable>: Hashable {
	
	// MARK: Exposed properties
	
	/// Unique vertex index for the whole graph.
	private(set) var index: UInt64
	
	/// Vertex wrapped content.
	private(set) var content: Content
	
	// MARK: - Init
	
	/// Creates an instance memberwise.
	init(index: UInt64, content: Content) {
		self.index = index
		self.content = content
	}
	
}
