//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 07.02.2023.
//

import Foundation

// MARK: - Protocol

/// Declaration that contain keyword.
public protocol Keywordable: Declaration {
	
	/// Static keyword of the declaration.
	var keyword: String { get }
	
}
