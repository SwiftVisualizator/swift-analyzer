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
    func contentNodes() -> [[String: Any]]
    func contentEdges() -> [[String: Any]]
}

public final class ContentGenerator {
    
    private let filesToCopy = ["index.html", "d3.min.js", "main.css"]
    private let fileManager = FileManager.default
    private lazy var targetPath = "/Users/whutao/code/study/swift-analyzer" + "/Visualization"
    
    public weak var dataSource: ContentDataSource?
    
    public init(dataSource: ContentDataSource? = nil) {
        self.dataSource = dataSource
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
    
    func writeGraphToFile(nodesData: [[String: Any]], linksData: [[String: Any]], fileName: String) {
        do {
            let nodesJsonData = try JSONSerialization.data(withJSONObject: nodesData, options: .prettyPrinted)
            let linksJsonData = try JSONSerialization.data(withJSONObject: linksData, options: .prettyPrinted)
            
            var jsonString =
                "var rawNodesData = " + String(data: nodesJsonData, encoding: .utf8)! + "\n" +
                "var rawLinksData = " + String(data: linksJsonData, encoding: .utf8)!
                        
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
