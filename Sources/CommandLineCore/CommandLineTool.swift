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
import SwiftVisualizer

// MARK: - Tool

public final class CommandLineTool  {
	
	// MARK: Private properties
	
	private let projectDirectory: URL
	
	// MARK: Init
	
	public init(arguments: [String] = CommandLine.arguments) {
		self.projectDirectory = URL(string: "/Users/whutao/code/study/swift-analyzer")!
//		self.projectDirectory = arguments.first.flatMap(URL.init(string:))!
	}
	
	// MARK: Exposed properties
	
	public func run() throws {
		let parser = Parser()
		let files = try parser.parse(
			directory: projectDirectory,
			allowedExtensions: ["swift"]
		)
		
		let analyzer = Analyzer()
		analyzer.consume(files: files)
		try analyzer.analyze()

        let generator = ContentGenerator()
        generator.dataSource = analyzer
        generator.generate()
	}
}

extension Analyzer: ContentDataSource {
    public func contentNodes() -> [[String: Any]] {
        let elements: [any Namable & Keywordable] =
            declarationAssembly.classDeclarations +
            declarationAssembly.structDeclarations +
            declarationAssembly.enumDeclarations +
            declarationAssembly.protocolDeclarations
        let roots = self.rootDeclarationDependencyMembers() ?? []
        
        return elements.map {
            ["name": $0.name, "type": $0.keyword]
        } + roots.map {
            ["name": $0.name, "type": "root"]
        }
    }
    
    public func contentEdges() -> [[String : Any]] {
        let elements: [any Namable & Inheritable] =
            declarationAssembly.classDeclarations +
            declarationAssembly.structDeclarations +
            declarationAssembly.enumDeclarations +
            declarationAssembly.protocolDeclarations
        return elements.flatMap { element in
            element.inheritances.map {
                ["source": element.name, "target": $0]
            }
        }
    }
}
