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
	
	private let arguments: [String]
	
	// MARK: Init
	
	public init(arguments: [String] = CommandLine.arguments) {
		self.arguments = arguments
	}
	
	// MARK: Exposed properties
	
	public func run() throws {
		let parser = Parser()
		let files = try parser.parse(
			directory: URL(string: "./")!,
			allowedExtensions: ["swift"]
		)
		
		let analyzer = Analyzer()
		analyzer.consume(files: files)
		try analyzer.analyze()
		
		let enums = analyzer.declarationAssembly.enumDeclarations
		let classes = analyzer.declarationAssembly.classDeclarations
		let protocols = analyzer.declarationAssembly.protocolDeclarations
		let structs = analyzer.declarationAssembly.structDeclarations
		let variables = analyzer.declarationAssembly.variableDeclarations
		let typealiases = analyzer.declarationAssembly.typealiasDeclarations
		let associatedTypes = analyzer.declarationAssembly.associatedTypeDeclarations
		let extensions = analyzer.declarationAssembly.extensionDeclarations
		let functions = analyzer.declarationAssembly.functionDeclarations
		let imports = analyzer.declarationAssembly.importDeclarations
		
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
		print("6. Found typealiases:")
		print(typealiases.map({ "  " + $0.description }).joined(separator: "\n"))
		print("======================================================")
		print("======================================================")
		print("7. Found associated types:")
		print(associatedTypes.map({ "  " + $0.description }).joined(separator: "\n"))
		print("======================================================")
		print("======================================================")
		print("8. Found extensions:")
		print(extensions.map({ "  " + $0.description }).joined(separator: "\n"))
		print("======================================================")
		print("======================================================")
		print("9. Found functions:")
		print(functions.map({ "  " + $0.description }).joined(separator: "\n"))
		print("======================================================")
		print("======================================================")
		print("10. Found imports:")
		print(imports.map({ "  " + $0.description }).joined(separator: "\n"))
		print("======================================================")
		print("======================================================")
		
		print(analyzer.rootDeclarationDependencyMembers())
        
        let generator = ContentGenerator()
        generator.dataSource = analyzer
        generator.generate()
	}
}

extension Analyzer: ContentDataSource {
    public func contentNodes() -> [NodeContentItem] {
        let roots = self.rootDeclarationDependencyMembers() ?? []
        
        let identifiableElements: [any Namable & Keywordable] =
            declarationAssembly.classDeclarations +
            declarationAssembly.structDeclarations +
            declarationAssembly.enumDeclarations +
            declarationAssembly.protocolDeclarations
        
        var dict: [String: NodeContentItem] = identifiableElements.reduce(into: [:]) { partialResult, element in
            partialResult[element.identifier] = NodeContentItem(
                name: element.name,
                type: element.keyword
            )
        }
        
        let descriptiveElements: [any Modifiable & CustomStringConvertible] =
            declarationAssembly.classDeclarations +
            declarationAssembly.structDeclarations +
            declarationAssembly.enumDeclarations +
            declarationAssembly.protocolDeclarations
        
        descriptiveElements.forEach { element in
            dict[element.identifier]?.metadata = NodeContentItem.Metadata(
                declaration: "\(element)",
                modifiers: element.modifiers.map(\.name)
            )
        }
        
        let genericElements: [any GenericParametable] = declarationAssembly.classDeclarations
        genericElements.forEach { element in
            if case let generics = element.genericParameters.map({ "\($0)" }), !generics.isEmpty {
                dict[element.identifier]?.metadata?.generics = generics
            }
        }
        
        roots.forEach { element in
            dict[element.name] = NodeContentItem(
                name: element.name,
                type: "root"
            )
        }
        
        return Array(dict.values)
        
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
