//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 06.02.2023.
//

import Foundation

extension URL {
	
	/// Returns true if a URL leads to a directory.
	var isDirectory: Bool {
		return (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
	}
	
}
