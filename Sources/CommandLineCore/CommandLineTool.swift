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
import SwiftAnalyzer

// MARK: - Tool

public final class CommandLineTool  {
	
	// MARK: Private properties
	
	private let arguments: [String]
	
	// MARK: Init
	
	public init(arguments: [String] = CommandLine.arguments) {
		self.arguments = arguments
	}
	
	// MARK: Exposed properties
	
	public func run() throws {
		let parser = Parser()
		let files = try parser.parse(
			directory: URL(string: "/Users/whutao/code/breaking-news-ios")!,
			allowedExtensions: ["swift"]
		)
		
		let analyzer = Analyzer()
		analyzer.consume(files: files)
		try analyzer.analyze()
		
		let enums = analyzer.declarationAssembly.enumDeclarations
		let classes = analyzer.declarationAssembly.classDeclarations
		let protocols = analyzer.declarationAssembly.protocolDeclarations
		let structs = analyzer.declarationAssembly.structureDeclarations
		let variables = analyzer.declarationAssembly.variableDeclarations
		
		print("======================================================")
		print("======================================================")
		print("1. Found classes:")
		print(classes.map({ "  " + $0.description }).joined(separator: "\n"))
		print("======================================================")
		print("======================================================")
		print("2. Found protocols:")
		print(protocols.map({ "  " + $0.description }).joined(separator: "\n"))
		print("======================================================")
		print("======================================================")
		print("3. Found variables:")
		print(variables.map({ "  " + $0.description }).joined(separator: "\n"))
		print("======================================================")
		print("======================================================")
		print("4. Found structs:")
		print(structs.map({ "  " + $0.description }).joined(separator: "\n"))
		print("======================================================")
		print("======================================================")
		print("5. Found enums:")
		print(enums.map({ "  " + $0.description }).joined(separator: "\n"))
		print("======================================================")
		print("======================================================")
		
		print(analyzer.rootDeclarationDependencyMembers())
	}
	
}
