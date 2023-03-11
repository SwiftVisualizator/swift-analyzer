//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 11.03.2023.
//

import Foundation
@testable import SwiftAnalyzer

// MARK: - Methods

/// Returns declaration assembly of a plain swift text.
internal func analyze(text: String) throws -> DeclarationAssembly {
	let analyser = Analyzer()
	analyser.consume(text: text)
	try analyser.analyze()
	return analyser.declarationAssembly
}

/// Returns declaration assembly of a set of plain swift texts.
internal func analyze(texts: String...) throws -> DeclarationAssembly {
	let analyser = Analyzer()
	texts.forEach(analyser.consume(text:))
	try analyser.analyze()
	return analyser.declarationAssembly
}
