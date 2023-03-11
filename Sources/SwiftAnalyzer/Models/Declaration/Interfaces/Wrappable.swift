//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 07.02.2023.
//

import Foundation

// MARK: - Protocol

/// Declaration that contains keyword.
public protocol Wrappable: Declaration {

	/// Declaration list(ordered) of wrappers.
	/// For example, `@available(iOS 13, *)`, `@Published`, `@main`.
	var wrappers: [Wrapper] { get }
	
}
