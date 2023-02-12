//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 07.02.2023.
//

import Foundation

// MARK: - Protocol

/// Declaration that contain information about inheritance.
public protocol Inheritable: Declaration {
	
	/// Ordered list of declaration inheritances.
	/// Inheritances are represented as class/protocol names.
	/// For example, `: A, B`.
	var inheritances: [String] { get }
	
}
