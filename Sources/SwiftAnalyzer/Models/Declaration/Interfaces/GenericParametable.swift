//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 07.02.2023.
//

import Foundation

// MARK: - Protocol

/// Declaration that contains information about generic parameters.
public protocol GenericParametable: Declaration {
	
	/// Ordered list of generic parameters. For example, `["A: Codable", "B"]`, `<A: Codable, B>`.
	var genericParameters: [GenericParameter] { get }
	
}
