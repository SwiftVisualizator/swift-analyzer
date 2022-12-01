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


// MARK: - Visitor

public final class Visitor: SyntaxRewriter {
    
    
    // MARK: Properties
    
    /// Result node forest.
    public private(set) var forest: Array<Node>
    
    /// Current node.
    public private(set) var currentNode: Node!
    
    /// Current row.
    public private(set) var row: Int
    
    /// Current column.
    public private(set) var column: Int
    
    
    // MARK: Init
    
    public init(for syntax: SourceFileSyntax) {
        
        self.forest = []
        self.row = 0
        self.column = 0
        
        super.init()
        
        self.visitPre(syntax._syntaxNode)
        _ = self.visit(syntax)
        
    }
    
    
    // MARK: Override
    
    public override func visitPre(_ node: Syntax) {
        
        let syntaxKindDescription: String = String(describing: node.syntaxNodeType)
        
        let newNode: Node = Node(
            syntaxKindDescription,
            range: Node.Location(
                startRow: row,
                startColumn: column,
                endRow: row,
                endColumn: column
            )
        )
        
        if let currentNode {
            currentNode.addChild(newNode)
        } else {
            forest.append(newNode)
        }
        
        currentNode = newNode
        
    }
    
    public override func visit(_ token: TokenSyntax) -> Syntax {
        
        currentNode.text = token.text
        currentNode.token = Node.Token(kind: "\(token.tokenKind)")
        
        currentNode.location.startRow = row
        currentNode.location.startColumn = column
        
        token.leadingTrivia.forEach(processTriviaPiece)
        processToken(token)
        token.leadingTrivia.forEach(processTriviaPiece)
        
        currentNode.location.endRow = row
        currentNode.location.endColumn = column
        
        return token._syntaxNode
        
    }
    
    public override func visitPost(_ node: Syntax) {
        currentNode.location.endRow = row
        currentNode.location.endColumn = column
        currentNode = currentNode.parent
    }
    
    
    // MARK: Helper
    
    private func replaceSymbols(text: String) -> String {
        return text
            .replacingOccurrences(of: "&nbsp;", with: "␣")
            .replacingOccurrences(of: "<br>", with: "↲")
    }
    
    private func processToken(_ token: TokenSyntax) {
        column = column + token.text.count
    }
    
    private func processTriviaPiece(_ piece: TriviaPiece){
        switch piece {
        case .spaces(let count):
            column = column + count
        case .tabs(let count):
            column = column + count * 2
        case .newlines(let count), .carriageReturns(let count), .carriageReturnLineFeeds(let count):
            row = row + count
            column = 0
        case .lineComment(let text):
            processComment(text)
        case .blockComment(let text):
            processComment(text)
        case .docLineComment(let text):
            processComment(text)
        case .docBlockComment(let text):
            processComment(text)
        case .verticalTabs, .formfeeds, .garbageText:
            break
        }
    }
    
    private func processComment(_ comment: String) {
        let commentRows: Array<String.SubSequence> = comment.split(
            separator: "\n",
            omittingEmptySubsequences: false
        )
        row = row + commentRows.count - 1
        column = column + commentRows.last!.count
    }
    
}
