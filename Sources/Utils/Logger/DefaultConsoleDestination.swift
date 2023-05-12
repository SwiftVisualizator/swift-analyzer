//
//  File.swift
//
//
//  Created by Roman Nabiullin on 12.05.2023.
//

import Foundation

// MARK: - Format

/// Default console destination that print log strings.
public final class DefaultConsoleDestination: LoggerDestinationProtocol {

	// MARK: Expsoed properties

	public var outputLevel: LogLevel

	public init(outputLevel: LogLevel = .verbose) {
		self.outputLevel = outputLevel
	}

	// MARK: Exposed methods

	public func process(string: String, level: LogLevel) {
		guard
			outputLevel <= level
		else {
			return
		}
		print(string)
	}

}
