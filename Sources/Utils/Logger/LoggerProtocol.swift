//
//  File.swift
//
//
//  Created by Roman Nabiullin on 12.05.2023.
//

import Foundation

// MARK: - Logger

/// Interface to work with logger.
public protocol LoggerProtocol {

	// MARK: Properties

	/// True if a logger is able to log events now.
	var isEnabled: Bool { get set }

	// MARK: Methods

	/// Sends a log event.
	func log(
		_ message: @autoclosure @escaping () -> Any?,
		level: LogLevel,
		fileName: StaticString,
		functionName: StaticString,
		lineNumber: Int
	)

	/// Adds a destination for log messages.
	func addDestination(_ destination: LoggerDestinationProtocol)

}

// MARK: - Log by level

extension LoggerProtocol {

	/// Sends verbose message.
	public func verbose(
		_ message: @autoclosure @escaping () -> Any?,
		fileName: StaticString = #file,
		functionName: StaticString = #function,
		lineNumber: Int = #line
	) {
		log(
			message,
			level: .verbose,
			fileName: fileName,
			functionName: functionName,
			lineNumber: lineNumber
		)
	}

	/// Sends info message.
	public func info(
		_ message: @autoclosure @escaping () -> Any?,
		fileName: StaticString = #file,
		functionName: StaticString = #function,
		lineNumber: Int = #line
	) {
		log(
			message,
			level: .info,
			fileName: fileName,
			functionName: functionName,
			lineNumber: lineNumber
		)
	}

	/// Sends debug message.
	public func debug(
		_ message: @autoclosure @escaping () -> Any?,
		fileName: StaticString = #file,
		functionName: StaticString = #function,
		lineNumber: Int = #line
	) {
		log(
			message,
			level: .debug,
			fileName: fileName,
			functionName: functionName,
			lineNumber: lineNumber
		)
	}

	/// Sends warning message.
	public func warning(
		_ message: @autoclosure @escaping () -> Any?,
		fileName: StaticString = #file,
		functionName: StaticString = #function,
		lineNumber: Int = #line
	) {
		log(
			message,
			level: .warning,
			fileName: fileName,
			functionName: functionName,
			lineNumber: lineNumber
		)
	}

	/// Sends error message.
	public func error(
		_ message: @autoclosure @escaping () -> Any?,
		fileName: StaticString = #file,
		functionName: StaticString = #function,
		lineNumber: Int = #line
	) {
		log(
			message,
			level: .error,
			fileName: fileName,
			functionName: functionName,
			lineNumber: lineNumber
		)
	}

	/// Sends severe error message.
	public func severe(
		_ message: @autoclosure @escaping () -> Any?,
		fileName: StaticString = #file,
		functionName: StaticString = #function,
		lineNumber: Int = #line
	) {
		log(
			message,
			level: .severe,
			fileName: fileName,
			functionName: functionName,
			lineNumber: lineNumber
		)
	}

}
