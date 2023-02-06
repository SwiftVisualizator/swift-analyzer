//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 06.02.2023.
//

import Foundation

extension URL {
	
	/// Returns true if a URL leads to a regular file.
	var isFile: Bool {
		return (try? resourceValues(forKeys: [.isRegularFileKey]))?.isRegularFile == true
	}
	
}
