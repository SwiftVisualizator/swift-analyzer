//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 12.02.2023.
//

import Foundation

// MARK: - Error

public enum DependencyError: Error {
	
	case cannotHaveChild(
		member: DeclarationDependencyMember,
		child: DeclarationDependencyMember
	)
	
}
