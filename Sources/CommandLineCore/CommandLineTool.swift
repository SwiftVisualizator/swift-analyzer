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
import Utils

// MARK: - Tool

public final class CommandLineTool  {
	
	// MARK: Private properties
	
	private let projectDirectory: URL
	
	private let outputURL: URL
	
	// MARK: Init
	
	public init(arguments: [String] = CommandLine.arguments) {
		guard
			arguments.count == 3,
			let inspectURL = URL(string: arguments[1]),
			let outputURL = URL(string: arguments[2])
		else {
			print("Please, provide a valid URL in the first argument.")
			print("The command should be \"swift run swift-analyzer PATH_TO\"")
			fatalError()
		}
		self.projectDirectory = inspectURL
		self.outputURL = outputURL
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
		
		let generator = ContentGenerator(
			targetPath: outputURL.absoluteString
		)
		generator.dataSource = analyzer
		generator.generate()
	}
	
}

extension Analyzer: ContentDataSource {
	public func contentNodes() -> [NodeContentItem] {
		let roots = self.rootDeclarationDependencyMembers() ?? []
		
		let identifiableElements: [any Namable & Keywordable] =
			declarationAssembly.actorDeclarations +
			declarationAssembly.classDeclarations +
			declarationAssembly.structDeclarations +
			declarationAssembly.enumDeclarations +
			declarationAssembly.protocolDeclarations
		
		var dict: [Int: NodeContentItem] = identifiableElements.reduce(into: [:]) { partialResult, element in
			partialResult[element.hashValue] = NodeContentItem(
				name: element.name,
				type: element.keyword
			)
		}
		
		let descriptiveElements: [any Modifiable & CustomStringConvertible] =
			declarationAssembly.actorDeclarations +
			declarationAssembly.classDeclarations +
			declarationAssembly.structDeclarations +
			declarationAssembly.enumDeclarations +
			declarationAssembly.protocolDeclarations
		
		descriptiveElements.forEach { element in
			dict[element.hashValue]?.metadata = NodeContentItem.Metadata(
				declaration: "\(element)",
				modifiers: element.modifiers.map(\.name)
			)
		}
		
		let genericElements: [any GenericParametable] = declarationAssembly.classDeclarations
		genericElements.forEach { element in
			if case let generics = element.genericParameters.map({ "\($0)" }), !generics.isEmpty {
				dict[element.hashValue]?.metadata?.generics = generics
			}
		}
		
		let locationElements: [any LocationMetaHolder & FileMetaHolder] =
			declarationAssembly.actorDeclarations +
			declarationAssembly.classDeclarations +
			declarationAssembly.structDeclarations +
			declarationAssembly.enumDeclarations +
			declarationAssembly.protocolDeclarations
		
		locationElements.forEach { element in
			if let fileMeta = element.fileMeta, let locationMeta = element.locationMeta {
				let location = "\(fileMeta.name):\(locationMeta.startRow)"
				dict[element.hashValue]?.metadata?.location = location
			}
		}
		
		let docsElements: [any DocStringMetaHolder] =
			declarationAssembly.actorDeclarations +
			declarationAssembly.classDeclarations +
			declarationAssembly.structDeclarations +
			declarationAssembly.enumDeclarations +
			declarationAssembly.protocolDeclarations
		
		docsElements.forEach { element in
			if let docsMeta = element.docStringMeta {
				dict[element.hashValue]?.metadata?.docs = docsMeta.docString
			}
		}
		
		let inheritanceElements: [any Inheritable] =
			declarationAssembly.actorDeclarations +
			declarationAssembly.classDeclarations +
			declarationAssembly.structDeclarations +
			declarationAssembly.enumDeclarations +
			declarationAssembly.protocolDeclarations
		
		inheritanceElements.forEach { element in
			dict[element.hashValue]?.metadata?.inheritance = element.inheritances
		}
		
		roots.forEach { element in
			dict[element.hashValue] = NodeContentItem(
				name: element.name,
				type: "root"
			)
		}
		
		return Array(dict.values)
		
	}
	
	public func contentEdges() -> [[String : Any]] {
		let elements: [any Namable & Inheritable] =
			declarationAssembly.actorDeclarations +
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
