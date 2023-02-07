//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 06.02.2023.
//

import Foundation

// MARK: - Model

/// Representation of a parsed file.
public struct ParsedFile {
	
	// MARK: Exposed properties
	
	/// File name.
	public var fileName: String? {
		return fileUrl?.lastPathComponent
	}
	
	/// File absolute URL.
	public let fileUrl: URL?
	
	/// String content of the file.
	public let content: String
	
	// MARK: Init
	
	/// Creates an instance memberwise.
	init(fileUrl: URL?, content: String) {
		self.fileUrl = fileUrl
		self.content = content
	}
	
}
