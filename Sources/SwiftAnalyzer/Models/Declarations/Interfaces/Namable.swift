//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 07.02.2023.
//

import Foundation

// MARK: - Protocol

/// Declaration that contain name.
public protocol Namable: Declaration {
	
	/// Declaration name.
	var name: String { get }
	
}
