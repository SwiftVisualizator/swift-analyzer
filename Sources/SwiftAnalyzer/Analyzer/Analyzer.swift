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
	
	// MARK: Exposed properties
	
	public private(set) var parsedFiles: [ParsedFile] = []
	
	public private(set) var declarationAssembly: DeclarationAssembly = DeclarationAssembly()
	
	// MARK: Private properties
	
	private var dependencyAnalyzer: DependencyAnalyzer?
	
	// MARK: Init
	
	/// Creates an instance of the analyzer.
	public init() {

	}
	
	// MARK: Exposed methods
	
	internal func consume(text: String) {
		let virtualFile = ParsedFile(
			fileUrl: nil,
			content: text
		)
		self.parsedFiles.append(virtualFile)
	}
	
	public func consume(file: ParsedFile) {
		self.parsedFiles.append(file)
	}
	
	public func consume(files: [ParsedFile]) {
		self.parsedFiles.append(contentsOf: files)
	}
	
	public func analyze() throws {
		try parsedFiles.forEach { file in
			// print("Processing \"\(file.fileName ?? "UNKNOWN FILE")\" ")
			
			let sourceFileSyntax = try SyntaxParser.parse(
				source: file.content
			)
			
			let rewriter = Rewriter(for: sourceFileSyntax)
			let forest: [Node] = rewriter.forest
			
			let declarationVisitor = DeclarationVisitor()
			declarationVisitor.walk(sourceFileSyntax)
			
			declarationAssembly.merge(declarationVisitor.assembly)
		}
		
		dependencyAnalyzer = try DependencyAnalyzer(
			declarations: declarationAssembly
		)
	}
	
	public func rootDeclarationDependencyMembers() -> Set<DeclarationDependencyMember>? {
		return try? dependencyAnalyzer?.rootDeclarationDependencyMembers()
	}
	
}
