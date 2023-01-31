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

public final class CommandLineTool  {
	
	private let arguments: [String]
	
	public init(arguments: [String] = CommandLine.arguments) {
		self.arguments = arguments
	}
	
	public func run() throws {
		let finder = SourceFinder()
		let urls = finder.getSourceFiles(allowedExtensions: ["swift"])
		if urls.isEmpty {
			print("Not found any *.swift files :(", urls)
		} else {
			print("Found *.swift files:")
			urls.forEach { url in
				print(url)
			}
		}
		
		let foundUrl = urls.first { $0.absoluteString.contains("SpecialOctoSystem.swift") }
		if let foundUrl, let content = try? String(contentsOf: foundUrl) {
			let analyzer = Analyzer()
			let forest = try analyzer.parse(content, filepath: "/src/test.swift")
			log.display(forest.first!)
		}
	}
	
}
