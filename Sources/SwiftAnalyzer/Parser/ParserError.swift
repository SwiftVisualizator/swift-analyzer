//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 06.02.2023.
//

import Foundation

// MARK: - Model

/// Errors that can be throws during file parsing.
public enum ParserError: Error {
	
	case unknown
	
	case cannotReadFile(url: URL?)
	
	case cannotReadDirectory(url: URL?)
	
	case noSuchFile(url: URL?)
	
	case notFile(url: URL?)
	
	case notDirectory(url: URL?)
	
	case notSwiftFile(url: URL?)
	
}
