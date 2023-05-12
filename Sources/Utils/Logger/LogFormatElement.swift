//
//  File.swift
//
//
//  Created by Roman Nabiullin on 12.05.2023.
//

import Foundation

// MARK: - Format

/// Logger output format element list.
public enum LogFormatElement {

	// MARK: Format elements

	/// Date when log function is called.
	case date

	/// Thread where log function is called.
	case threadName

	/// Function where log function is called.
	case functionName

	/// File where log function is called.
	case fileName

	/// Line where log function is called.
	case lineNumber

	/// Log level with which log function is called.
	case logLevel

	/// Log level symbol with which log function is called.
	case logLevelSymbol

	/// Log string, the content.
	case logString

	// MARK: Symbols

	/// Custom string.
	case text(String)

	/// `"."` string.
	case dot

	/// `","` string.
	case comma

	/// `"-"` string.
	case dash

	/// `" " * count` string.
	case space(count: Int = 1)

	/// `"\n" * count` string.
	case newLine(count: Int = 1)

	/// `"("` string.
	case leftParanthesis

	/// `"["` string.
	case leftBracket

	/// `")"` string.
	case rightParanthesis

	/// `"]"` string.
	case rightBracket

}
