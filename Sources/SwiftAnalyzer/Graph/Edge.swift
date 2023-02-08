//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 07.02.2023.
//

import Foundation

// MARK: - Model

/// Graph directed edge representation.
struct DirectedEdge<Content: Hashable> {
	
	// MARK: Exposed properties
	
	let from: Vertex<Content>
	
	let to: Vertex<Content>
	
	// MARK: Init
	
	/// Creates an instance memberwise.
	init(from: Vertex<Content>, to: Vertex<Content>) {
		self.from = from
		self.to = to
	}
	
}
