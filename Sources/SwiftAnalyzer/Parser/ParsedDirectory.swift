//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 06.02.2023.
//

import Foundation

// MARK: - Model

/// Representation of a parsed directory.
public struct PardsedDirectory {
	
	// MARK: Exposed properties
	
	/// Top level files right inside this directories.
	public internal(set) var files: [ParsedFile]
	
	/// Subdirectories list.
	public internal(set) var directories: [PardsedDirectory]
	
	/// All files including those in the subdirectories.
	public var allFiles: [ParsedFile] {
		return files + directories.flatMap(\.allFiles)
	}
	
	// MARK: Init
	
	/// Creates an instance memberwise.
	init(files: [ParsedFile] = [], directories: [PardsedDirectory] = []) {
		self.files = files
		self.directories = directories
	}
	
}
