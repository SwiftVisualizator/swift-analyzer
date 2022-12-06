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


// MARK: - Math operation

fileprivate enum MathOperation {
    
    case addition
    
    case subtraction
    
    case multiplication
    
    case division
    
    
    fileprivate static func perform(
        _ operation: MathOperation,
        with lhs: Double,
        and rhs: Double
    ) -> Double {
        switch operation {
        case .addition:
            return lhs + rhs
        case .subtraction:
            return lhs - rhs
        case .multiplication:
            return lhs * rhs
        case .division:
            return lhs / rhs
        }
    }
    
}


// MARK: - Computable expression

public protocol ComputableExpression {
    
    var leftArgument: Double { get }
    
    var rightArgument: Double { get }
    
    func computeResult() -> Double
    
}


// MARK: - Base expression

public class MathExpression: ComputableExpression, Codable {
    
    
    private let lhs: Double
    
    private let rhs: Double
    
    
    public init(lhs: Double, rhs: Double) {
        self.lhs = lhs
        self.rhs = rhs
    }
    
    
    public final var leftArgument: Double {
        return lhs
    }
    
    public final var rightArgument: Double {
        return rhs
    }
    
    public func computeResult() -> Double {
        fatalError("Not implemented for base class!")
    }
    
}


// MARK: Multiplication expression

public final class MultiplicationExpression: MathExpression {
    
    public override func computeResult() -> Double {
        return MathOperation.perform(
            .multiplication,
            with: leftArgument,
            and: rightArgument
        )
    }
    
}



// MARK: Addition expression

public class AdditionExpression: MathExpression {
    
    public override func computeResult() -> Double {
        return MathOperation.perform(
            .addition,
            with: leftArgument,
            and: rightArgument
        )
    }
    
}


public final class PrettyAdditionExpression: AdditionExpression {
    
    public func toString() -> String {
        return String(format: "%d + %d = %d", arguments: [leftArgument, rightArgument, computeResult()])
    }
}


// MARK: Solving example

internal struct Solver {
    internal init() {}
    
    internal func solveAddition() {
        
        let additionExpresison = PrettyAdditionExpression(lhs: 9.0, rhs: 10.0)
        
        let isResultEqualTo19 = (additionExpresison.computeResult() == 19.0)
        
        if isResultEqualTo19 {
            print(additionExpresison.toString())
        }
    }
}