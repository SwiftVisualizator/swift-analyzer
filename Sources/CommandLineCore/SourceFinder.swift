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

struct SourceFinder {

	var rootPath = "."
	
	func getSourceFiles(allowedExtensions: Set<String>) -> [URL] {
		guard let rootUrl = URL(string: rootPath) else { return [] }
		
		var foundUrls: [URL] = []
		if let enumerator = FileManager.default.enumerator(
			at: rootUrl,
			includingPropertiesForKeys: [.isRegularFileKey],
			options: [.skipsHiddenFiles, .skipsPackageDescendants]
		) {
			for case let fileUrl as URL in enumerator {
				guard
					let fileAttributes = try? fileUrl.resourceValues(forKeys:[.isRegularFileKey]),
					fileAttributes.isRegularFile == true
				else {
					continue
				}
				if allowedExtensions.contains(fileUrl.pathExtension) {
					foundUrls.append(fileUrl)
				}
			}
		}
		
		return foundUrls
	}

}
