//
//  File.swift
//
//
//  Created by Roman Nabiullin on 12.05.2023.
//

import Foundation

// MARK: - Format

/// Logger output format.
public struct LogFormat {

	// MARK: Exposed properties

	/// Default format with extensive format.
	public static let `default`: LogFormat = LogFormat(arguments: [
		.leftBracket, .date, .rightBracket,
		.space(), .logLevelSymbol, .space(), .logLevel, .space(),
		.leftParanthesis,
		.fileName, .comma,
		.space(), .functionName, .comma,
		.space(), .text("line"),
		.space(), .lineNumber,
		.rightParanthesis,
		.space(), .dash, .space(), .text("\""), .logString, .text("\"")
	])

	/// Format arguments.
	public let arguments: [LogFormatElement]

	// MARK: Init

	/// Creates a format from arguments.
	public init(arguments: [LogFormatElement]) {
		self.arguments = arguments
	}

	// MARK: Exposed methods

	/// Transform log event into a string using format.
	public func format(
		string: String,
		level: LogLevel,
		dateFormat: String,
		functionName: String,
		fileName: String,
		lineNumber: Int
	) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter .dateFormat = dateFormat
		return arguments.map { element -> String in
			switch element {
			case .date:
				return dateFormatter.string(from: Date())
			case .threadName:
				return Thread.current.name ?? "*unknown*"
			case .functionName:
				return String(describing: functionName)
			case .fileName:
				return String(describing: fileName)
			case .lineNumber:
				return String(describing: lineNumber)
			case .logLevel:
				return level.name.uppercased()
			case .logLevelSymbol:
				return level.symbol
			case .logString:
				return string
			case .dot:
				return "."
			case .comma:
				return ","
			case .dash:
				return "-"
			case .space(count: let count):
				return String(repeating: " ", count: count)
			case .newLine(count: let count):
				return String(repeating: "\n", count: count)
			case .leftParanthesis:
				return "("
			case .leftBracket:
				return "["
			case .rightParanthesis:
				return ")"
			case .rightBracket:
				return "]"
			case .text(let text):
				return text
			}
		}
		.joined(separator: "")
	}

}
