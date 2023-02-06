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

import XCTest
import SwiftSyntax
import SwiftSyntaxParser
@testable import SwiftAnalyzer

final class SwiftAnalyzerTests: XCTestCase {
	
	func testParsing() throws {
		//		let analyzer = Analyzer()
		//		let forest = try analyzer.parse(smolSample, filepath: "/src/abobus.swift")
		
		let sourceFileSyntax = try SyntaxParser.parse(
			source: smolSample
		)
		
		let visitor = DeclarationVisitor()
		visitor.walk(sourceFileSyntax)
		
		print("")
		print(visitor.classDeclarations.map(\.description).joined(separator: "\n"))
		print("")
		print(visitor.protocolDeclarations.map(\.description).joined(separator: "\n"))
		print("")
		print(visitor.structureDeclarations.map(\.description).joined(separator: "\n"))
		print("")
		print(visitor.variableDeclarations.map(\.description).joined(separator: "\n"))
		print("")
	}
	
}
