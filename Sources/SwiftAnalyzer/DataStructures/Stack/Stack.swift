//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 12.02.2023.
//

import Foundation

// MARK: - Structure

/// Primitive stack model.
final class Stack<Content> {
	
	// MARK: Exposed properties
	
	var isEmpty: Bool {
		return body.isEmpty
	}
	
	// MARK: Private properties
	
	private var body: [Content]
	
	// MARK: Init
	
	/// Creates a stack.
	init(_ ininialBody: [Content] = []) {
		self.body = ininialBody
	}
	
	// MARK: Exposed methods
	
	/// `O(1)`. Appends an element to the stack.
	func push(_ element: Content) {
		body.append(element)
	}
	
	/// `O(1)`. Returns the last element (does not remove it).
	func peek() -> Content? {
		return body.last
	}
	
	/// `O(1)`. Removes and returns the last element if possible.
	func pop() -> Content? {
		return body.popLast()
	}
	
}
