//
//
//  MIT License
//
//  Copyright (c) 2022-Present
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//  

import Foundation
import SwiftSyntax
import SwiftSyntaxParser


// MARK: - Analyzer

public final class Analyzer {
	
	// MARK: Private properties
	
	/// Already parsed files. Keys are local file paths and values are SwiftSyntax models.
	private var files: Dictionary<String, [Node]>
	
	
	// MARK: Init
	
	/// Creates an instance of the analyzer.
	public init() {
		self.files = [:]
	}
	
	// MARK: Exposed methods
	
	/// Parses the source code file string. Stores the source file syntax locally.
	@discardableResult public func parse(
		_ string: String,
		filepath: String
	) throws -> Array<Node> {
		let sourceFileSyntax = try SyntaxParser.parse(source: string)
		let visitor = Visitor(for: sourceFileSyntax)
		let forest: Array<Node> = visitor.forest
		
		files[filepath] = forest
		
		return forest
	}
	
	/// Get children of a node.
	public static func children<S: SyntaxProtocol>(of node: S) -> SyntaxChildren {
		return node.children
	}
	
}
