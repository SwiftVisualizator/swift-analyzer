//
//  DocStringMeta.swift
//  
//
//  Created by Roman Nabiullin on 18.04.2023.
//

import Foundation
import SwiftSyntax

// MARK: - Model

/// Meta information about a declaration docstring.
public struct DocStringMeta: Equatable, Hashable, Codable {
	
	// MARK: - Exposed properties
	
	/// Docstring.
	public internal(set) var docString: String

	// MARK: - Init
	
	init?<Syntax: SyntaxProtocol>(node: Syntax) {
		guard
			let docString = node.leadingTrivia?
				.compactMap({ trivia -> String? in
					switch trivia {
					case let .docLineComment(text):
						return text.trimmingCharacters(in: .whitespaces)
					case let .docBlockComment(text):
						return text.trimmingCharacters(in: .whitespacesAndNewlines)
					default:
						return nil
					}
				})
				.joined(separator: "\n"),
			!docString.isEmpty
		else {
			return nil
		}
		self.docString = docString
	}
	
}
