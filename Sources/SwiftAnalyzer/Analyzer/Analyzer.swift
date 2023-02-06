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
	private var files: Dictionary<String, [Node]> = [:]

	private var topLevelNodes: [Node] = []
	
	
	// MARK: Init
	
	/// Creates an instance of the analyzer.
	public init() {

	}
	
	// MARK: Exposed methods
	
	@discardableResult public func parse(
		_ string: String,
		filepath: String
	) throws -> Array<Node> {
		let sourceFileSyntax = try SyntaxParser.parse(source: string)
		let visitor = Rewriter(for: sourceFileSyntax)
		let forest: Array<Node> = visitor.forest
		
		files[filepath] = forest
		
		return forest
	}
	
	public func analyze(string: String) throws {
		let sourceFileSyntax = try SyntaxParser.parse(source: string)
		
		let rewriter = Rewriter(for: sourceFileSyntax)
		let forest: [Node] = rewriter.forest
		
		let declarationVisitor = DeclarationVisitor()
		declarationVisitor.walk(sourceFileSyntax)
		let classes = declarationVisitor.classDeclarations
		
		print(classes.map(\.description).joined(separator: "\n"))
	}
	
	public func analyze(file: ParsedFile) throws {
		let sourceFileSyntax = try SyntaxParser.parse(source: file.content)
	}
	
	public func accumulate(directory: PardsedDirectory) {
		
	}
	
}
