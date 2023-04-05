//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 11.03.2023.
//

import Foundation

// MARK: - Protocol

/// Declaration that contains information about generic requirements.
public protocol GenericRequirementable: Declaration {
	
	/// Ordered list of generic requirements.
	/// For example, `["A: Codable", "B == String"]`, `where A: Codable, B == String`.
	var genericRequirements: [GenericRequirement] { get }
	
}
