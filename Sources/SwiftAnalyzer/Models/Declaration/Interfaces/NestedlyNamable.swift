//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 12.05.2023.
//

import Foundation

// MARK: - Protocol

/// Declaration that contains name in a full nested manner.
/// For example: `DatabaseManager.MirgrationUtil.Error`.
public protocol NestedlyNamable: Declaration {
	
	/// Declaration nested name.
	var nestedName: String { get }
	
}
