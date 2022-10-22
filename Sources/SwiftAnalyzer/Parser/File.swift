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


// MARK: - Model

/// File representation.
public struct File {
    
    
    /// Unique identifier type.
    public typealias Identifier = UUID
    
    
    /// File unique identifier
    public let identifier: Identifier
    
    /// The content of the file.
    public let content: String
    
    /// File absolute path in the current file system.
    public let path: String
    
    
    /// Crates an instance by assigning all properties.
    public init(
        identifier: Identifier,
        content: String,
        path: String
    ) {
        self.identifier = identifier
        self.content = content
        self.path = path
    }
    
    /// Crates an instance by reading the file.
    public init(path: String, encoding: String.Encoding = .utf8) throws {
        self.identifier = UUID()
        self.path = path
        self.content = try String(contentsOfFile: path, encoding: encoding)
    }
    
}
