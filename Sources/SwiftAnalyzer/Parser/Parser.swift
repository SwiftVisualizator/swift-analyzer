//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 06.02.2023.
//

import Foundation

// MARK: - Parser

/// Synchronous parser that allows to read files from the filesystem.
public final class Parser: ParserProtocol {
	
	// MARK: Private properties

	/// File system API.
	private let fileManager: FileManager = .default
	
	/// Encoding in which files will be decoded.
	private let defaultEncoding: String.Encoding = .utf8
	
	// MARK: Init
	
	public init() {
		
	}
	
	// MARK: Exposed properties
	
	func parse(file fileUrl: URL) throws -> ParsedFile {
		guard
			fileManager.fileExists(atPath: fileUrl.absoluteString)
		else {
			throw ParserError.noSuchFile(url: fileUrl)
		}
		
		guard
			fileUrl.isFile
		else {
			throw ParserError.notFile(url: fileUrl)
		}
		
		guard
			fileUrl.pathExtension == "swift"
		else {
			throw ParserError.notSwiftFile(url: fileUrl)
		}
		
		do {
			let content = try String(contentsOf: fileUrl, encoding: defaultEncoding)
			return ParsedFile(
				fileName: fileUrl.lastPathComponent,
				fileUrl: fileUrl,
				content: content
			)
		} catch {
			throw ParserError.cannotReadFile(url: fileUrl)
		}
	}
	
	func parse(directory directoryUrl: URL) throws -> PardsedDirectory {
		guard
			directoryUrl.isDirectory
		else {
			throw ParserError.notDirectory(url: directoryUrl)
		}
		
		guard
			let directoryEnumerator = fileManager.enumerator(
				at: directoryUrl,
				includingPropertiesForKeys: [.isRegularFileKey],
				options: [.skipsHiddenFiles, .skipsPackageDescendants]
			)
		else {
			throw ParserError.cannotReadDirectory(url: directoryUrl)
		}
		
		var result: PardsedDirectory = PardsedDirectory()
		
		let foundUrls: Array<URL> = fileManager.enumerator(
			at: directoryUrl,
			includingPropertiesForKeys: [.isRegularFileKey],
			options: [.skipsHiddenFiles, .skipsPackageDescendants]
		)?.compactMap { $0 as? URL } ?? []
		
		try foundUrls.forEach { url in
			if url.isFile {
				let parsedFile = try parse(file: url)
				result.files.append(parsedFile)
			} else if url.isDirectory {
				let parsedDirectory = try parse(directory: url)
				result.directories.append(parsedDirectory)
			}
		}
		
		return result
	}
	
}
