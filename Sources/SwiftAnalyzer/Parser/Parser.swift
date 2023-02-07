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
	
	public init(){
		
	}
	
	// MARK: Exposed properties
	
	public func parse(
		file fileUrl: URL,
		allowedExtensions: Set<String>
	) throws -> ParsedFile {
		guard
			fileUrl.isFile
		else {
			throw ParserError.notFile(url: fileUrl)
		}
		
		guard
			allowedExtensions.contains(fileUrl.pathExtension)
		else {
			throw ParserError.notAllowedFileExtension(
				url: fileUrl,
				allowedExtensions: allowedExtensions
			)
		}
		
		do {
			let content = try String(contentsOf: fileUrl, encoding: defaultEncoding)
			return ParsedFile(
				fileUrl: fileUrl,
				content: content
			)
		} catch {
			throw ParserError.cannotReadFile(url: fileUrl)
		}
	}
	
	public func parse(
		directory directoryUrl: URL,
		allowedExtensions: Set<String>
	) throws -> [ParsedFile] {
		guard
			let directoryEnumerator = fileManager.enumerator(
				at: directoryUrl,
				includingPropertiesForKeys: [.isRegularFileKey],
				options: [.skipsHiddenFiles, .skipsPackageDescendants]
			)
		else {
			throw ParserError.cannotReadDirectory(url: directoryUrl)
		}
		
		let foundFileUrls: [URL] = directoryEnumerator
			.compactMap { $0 as? URL }
			.filter(\.isFile)
		
		return foundFileUrls.compactMap { foundUrl in
			do {
				return try parse(
					file: foundUrl,
					allowedExtensions: allowedExtensions
				)
			} catch let error {
				if let error = error as? ParserError {
					switch error {
					case let .cannotReadFile(url):
						if let url {
							print("Cannot read file \(url)")
						}
					case let .noSuchFile(url):
						if let url {
							print("No such file \(url)")
						}
					case let .notFile(url):
						if let url {
							print("Not a file \(url)")
						}
					case let .notAllowedFileExtension(url, extensions):
						if let url, let extensions {
							print("File \(url) is not \(extensions)")
						}
					case .cannotReadDirectory, .unknown:
						break
					}
				}
				
				return nil
			}
		}
	}
	
}
