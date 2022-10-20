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
import SwiftSyntax
import SwiftParser


let code: String = """
import Foundation


struct Point: Equatable, Codable, Hashable {

    var x: Double = 0.0

    var y: Double = 0.0

}

let p1 = Point(x: 3.0, y: 1.0)
let p2 = Point(x: -4.0, y: 2.0)


print(p1 == p2)
"""


public struct swift_analyzer {
    
    public init() {
        
        let rootNode: SourceFileSyntax = Parser.parse(source: code)
        
        recursivePrint(node: Syntax(rootNode), indent: 0)
        
    }
    
}

func recursivePrint(node: Syntax,  indent: Int) {
    let indentString = String(repeating: "  ", count: indent)
    let nodeName = String(describing: node.customMirror.subjectType)
    print(indentString + nodeName)
    for child in node.children(viewMode: .all) {
        recursivePrint(node: child, indent: indent + 1)
    }
}
