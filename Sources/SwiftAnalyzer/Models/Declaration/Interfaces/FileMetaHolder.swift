//
//  FileMetaHolder.swift
//  
//
//  Created by Roman Nabiullin on 05.04.2023.
//

import Foundation

// MARK: - Protocol

/// Declaration that contains meta information about its source file.
public protocol FileMetaHolder: Declaration {
	
	// MARK: Properties
	
	/// Meta information about the file location.
	var fileMeta: FileMeta? { get set }
	
}
