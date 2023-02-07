//
//  ParserProtocol.swift
//  
//
//  Created by Roman Nabiullin on 31.01.2023.
//

import Foundation

// MARK: - Protocol

/// Interface for working with file parsing.
public protocol ParserProtocol {
	
	// MARK: Methods
	
	/// Parses given URL as a source code file.
	///
	/// - Throws ParserError if an internal error occured.
	func parse(
		file fileUrl: URL,
		allowedExtensions: Set<String>
	) throws -> ParsedFile
	
	/// Parses given URL as a directory containing source code files (and subdirectories).
	///
	/// - Throws ParserError if an internal error occured.
	func parse(
		directory directoryUrl: URL,
		allowedExtensions: Set<String>
	) throws -> [ParsedFile]
	
}
