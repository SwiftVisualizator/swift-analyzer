//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 24.03.2023.
//

import Foundation

// MARK: - Model

/// Meta information about the row location in some file.
public struct LocationMeta: Equatable, Hashable, Codable {
	
	// MARK: - Exposed properties
	
	/// The start row of the declaration in its file.
	public internal(set) var startRow: Int
	
	/// The end row of the declaration in its file.
	public internal(set) var endRow: Int
	
}
