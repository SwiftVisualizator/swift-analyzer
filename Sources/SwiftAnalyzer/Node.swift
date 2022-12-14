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


// MARK: - Node

/// Syntax tree node
public final class Node {
    
    
    // MARK: Properties
    
    /// Node text.
    public var text: String
    
    /// Node range in a source file.
    public var location: Node.Location
    
    /// Node wrapped token.
    public var token: Node.Token
    
    /// Optional parent node.
    public weak var parent: Node?
    
    /// Node children list.
    public private(set) var childen: Array<Node>
    
    
    // MARK: Init
    
    /// Creates instance of node from the text.
    public init(_ text: String, range: Node.Location) {
        self.text = text
        self.location = range
        self.parent = nil
        self.childen = []
        self.token = Node.Token(kind: nil)
    }
    
    
    // MARK: Helper
    
    /// Insert child node.
    public func addChild(_ node: Node) {
        childen.append(node)
        node.parent = self
    }
    
}


// MARK: - Description

extension Node: CustomStringConvertible {
    
    
    public var description: String {
        var string = "Node("
        string += "text: \"\(text)\", "
        if let kind = token.kind {
            string += "kind: \"\(kind)\", "
        } else {
            string += "kind: \"UNKNOWN\", "
        }
        string += "start: (\(location.startRow), \(location.startColumn)), "
        string += "end: (\(location.endRow), \(location.endColumn))"
        string += ")"
        return string
    }
    
}


// MARK: - Token

extension Node {
    
    
    /// Wrapped token.
    public struct Token {
        
        /// Token kind string.
        public var kind: String?
        
    }
    
}


// MARK: - Location

extension Node {
    
    
    /// Node range in a file.
    public struct Location {
        
        /// Node start row.
        public var startRow: Int
        
        /// Node start column.
        public var startColumn: Int
        
        /// Node end row.
        public var endRow: Int
        
        /// Node end column.
        public var endColumn: Int
        
    }
    
}
