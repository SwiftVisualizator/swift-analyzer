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

public protocol ContentDataSource: AnyObject {
    func contentNodes() -> [NodeContentItem]
    func contentEdges() -> [[String: Any]]
}

public struct NodeContentItem: Encodable {
    public struct Metadata: Encodable {
        public var declaration: String?
        public var modifiers: [String]?
        public var inheritance: [String]?
        public var generics: [String]?
        public var location: String?
        public var docs: String?
        
        public init(declaration: String? = nil, modifiers: [String]? = nil) {
            self.declaration = declaration
            self.modifiers = modifiers
        }
    }
    
    public var name: String?
    public var type: String?
    public var metadata: Metadata?
    
    public init(name: String? = nil, type: String? = nil, metadata: Metadata? = nil) {
        self.name = name
        self.type = type
        self.metadata = metadata
    }
}


public final class ContentGenerator {
    
    private let filesToCopy: [String] = ["index.html", "d3.min.js", "main.css", "main.js"]
	private let fileManager: FileManager
	private let targetPath: String
    
    public weak var dataSource: ContentDataSource?
    
	public init(
		dataSource: ContentDataSource? = nil,
		targetPath: String? = nil
	) {
		let fileManager = FileManager.default
		
		self.fileManager = fileManager
        self.dataSource = dataSource
		self.targetPath = targetPath ?? (fileManager.currentDirectoryPath + "/Visualization")
    }
    
    public func generate() {
        copyResources()
    }
    
    private func copyResources() {
        createDirectoryIfNeeded(path: targetPath)
        
        for fileName in filesToCopy {
            guard let sourceUrl = Bundle.module.url(forResource: fileName, withExtension: nil) else {
                print("Error finding source file: \(fileName)")
                continue
            }
            
            var targetUrl = URL(fileURLWithPath: targetPath)
            if fileName.hasSuffix(".js") {
                targetUrl.appendPathComponent("js")
            } else if fileName.hasSuffix(".css") {
                targetUrl.appendPathComponent("css")
            }
            
            createDirectoryIfNeeded(path: targetUrl.path)
            targetUrl.appendPathComponent(fileName)
            
            do {
                if fileManager.fileExists(atPath: targetUrl.path) {
                    try fileManager.removeItem(at: targetUrl)
                }
                try fileManager.copyItem(at: sourceUrl, to: targetUrl)
                print("File \(fileName) copied to destination.")
            } catch {
                print("Error copying file \(fileName): \(error.localizedDescription)")
            }
        }
        
        let jsonFileName = "data.js"
        let jsonFilePath = targetPath + "/js/" + jsonFileName
        
        let nodesData = dataSource?.contentNodes() ?? []
        let linksData = dataSource?.contentEdges() ?? []
        writeGraphToFile(nodesData: nodesData, linksData: linksData, fileName: jsonFilePath)
    }
    
    func writeGraphToFile(nodesData: [NodeContentItem], linksData: [[String: Any]], fileName: String) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let nodesJsonData = try encoder.encode(nodesData)
            let linksJsonData = try JSONSerialization.data(withJSONObject: linksData, options: .prettyPrinted)
            
            let jsonString =
                "var rawNodesData = " + String(data: nodesJsonData, encoding: .utf8)! + ";" +
                "var rawLinksData = " + String(data: linksJsonData, encoding: .utf8)! + ";"
            let fileUrl = URL(fileURLWithPath: fileName)
            try jsonString.write(to: fileUrl, atomically: true, encoding: .utf8)
            
            print("Dictionary written to file: \(fileName)")
        } catch {
            print("Error writing dictionary to file: \(error.localizedDescription)")
        }
    }
    
    private func createDirectoryIfNeeded(path: String) {
        
        if !fileManager.fileExists(atPath: path) {
            do {
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating target directory: \(error.localizedDescription)")
                return
            }
        }
    }
}
