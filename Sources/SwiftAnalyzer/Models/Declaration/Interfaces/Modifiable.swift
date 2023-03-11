//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 07.02.2023.
//

import Foundation

// MARK: - Protocol

/// Declaration that contains modifiers.
public protocol Modifiable: Declaration {
	
	/// Declaration modifiers. For exmaple, `public`, `final`.
	var modifiers: [Modifier] { get }
	
}
