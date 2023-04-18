//
//  DocStringMetaHolder.swift
//  
//
//  Created by Roman Nabiullin on 18.04.2023.
//

import Foundation

// MARK: - Protocol

/// Declaration that contains meta information about its docstring.
public protocol DocStringMetaHolder: Declaration {
	
	// MARK: Properties
	
	/// Docstring meta information.
	var docStringMeta: DocStringMeta? { get set }
	
}
