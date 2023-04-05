//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 24.03.2023.
//

import Foundation

// MARK: - Protocol

/// Declaration that contains meta information about the row location in some file.
public protocol LocationMetaHolder: Declaration {
	
	// MARK: Properties
	
	/// Meta information about location in a file.
	var locationMeta: LocationMeta? { get set }
	
}
