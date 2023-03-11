//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 11.03.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

/// A function signature.
public struct FunctionSignature: Equatable, Hashable, Codable {
	
	// MARK: Exposed properties
	
	/// The function inputs.
	public let inputParameters: [FunctionParameter]
	
	/// The function output type if present.
	public let outputType: String?
	
	/// The `async` or `reasync` keyword if present.
	public let asyncOrReasyncKeyword: String?
	
	/// The `throws` or `rethrows` keyword if present.
	public let throwsOrRethrowsKeyword: String?
	
	// MARK: Init
	
	/// Creates an instance from SwiftSyntax model.
	init(node: FunctionSignatureSyntax) {
		self.inputParameters = node.input.parameterList
			.map(FunctionParameter.init(node:))
		self.outputType = node.output?.returnType.description.trimmed
		self.throwsOrRethrowsKeyword = node.throwsOrRethrowsKeyword?.description.trimmed
		self.asyncOrReasyncKeyword = node.asyncOrReasyncKeyword?.description.trimmed
	}
	
}

// MARK: - CustomStringConvertible

extension FunctionSignature: CustomStringConvertible {
	
	public var description: String {
		var result: String = ""
		result += "("
		result += inputParameters.map(\.description).joined(separator: ", ")
		result += ")"
		
		result += [asyncOrReasyncKeyword, throwsOrRethrowsKeyword]
			.compactMap(\.?.description)
			.joined(separator: " ")
			.asString
		
		if let outputType {
			result += " -> \(outputType)"
		}
		
		return result
	}
	
}

