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
	
	private var files: [ParsedFile] = []
	
	
	// MARK: Init
	
	/// Creates an instance of the analyzer.
	public init() {

	}
	
	// MARK: Exposed methods
	
	public func consume(file: ParsedFile) {
		self.files.append(file)
	}
	
	public func consume(files: [ParsedFile]) {
		self.files.append(contentsOf: files)
	}
	
	public func analyze() throws {
		try files.forEach { file in
			let sourceFileSyntax = try SyntaxParser.parse(
				source: file.content
			)
			
			let rewriter = Rewriter(for: sourceFileSyntax)
			let forest: [Node] = rewriter.forest
			
			let declarationVisitor = DeclarationVisitor()
			declarationVisitor.walk(sourceFileSyntax)
			let classes = declarationVisitor.assembly.classDeclarations
			let protocols = declarationVisitor.assembly.protocolDeclarations
			let structs = declarationVisitor.assembly.structureDeclarations
			let variables = declarationVisitor.assembly.variableDeclarations
			
			print("======================================================")
			print("  Processing \"\(file.fileName ?? "UNKNOWN FILE")\" ")
			print("======================================================")
			print("1. Found classes:")
			print(classes.map({ "  " + $0.description }).joined(separator: "\n"))
			print("2. Found protocols:")
			print(protocols.map({ "  " + $0.description }).joined(separator: "\n"))
			print("3. Found variables:")
			print(variables.map({ "  " + $0.description }).joined(separator: "\n"))
			print("4. Found structs:")
			print(structs.map({ "  " + $0.description }).joined(separator: "\n"))
			print("======================================================")
		}
	}
	
}
