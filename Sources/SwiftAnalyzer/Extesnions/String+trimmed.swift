//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 06.02.2023.
//

import Foundation

extension String {
	
	/// String without leading/trailing whitespace/newline characters.
	var trimmed: String {
		return trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
}
