//
//  FileMeta.swift
//  
//
//  Created by Roman Nabiullin on 05.04.2023.
//

import Foundation

// MARK: - Model

/// Meta information about the file location.
public struct FileMeta: Equatable, Hashable, Codable {
	
	// MARK: - Exposed properties
	
	/// File name.
	public internal(set) var name: String
	
}
