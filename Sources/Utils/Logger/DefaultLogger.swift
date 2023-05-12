//
//  File.swift
//
//
//  Created by Roman Nabiullin on 12.05.2023.
//

import Foundation

// MARK: - Format

/// Standard primitive logger.
public final class DefaultLogger: LoggerProtocol {

	// MARK: Exposed properties

	public var isEnabled: Bool = false

	// MARK: Private properties

	private var destinations: [LoggerDestinationProtocol] = []

	private let logFormat: LogFormat

	private let dateFormat: String

	// MARK: Init

	public init(
		logFormat: LogFormat = .default,
		dateFormat: String = "yyyy-MM-dd HH:mm:ss"
	) {
		self.logFormat = logFormat
		self.dateFormat = dateFormat
	}

	// MARK: Exposed methods

	public func log(
		_ message: @autoclosure @escaping () -> Any?,
		level: LogLevel,
		fileName: StaticString,
		functionName: StaticString,
		lineNumber: Int
	) {
		guard isEnabled else { return }

		let message: String = {
			if let text = message() {
				return String(describing: text)
			} else {
				return "nil"
			}
		}()

		let fileName: String = {
			if let fileNameComponent = String(describing: fileName).split(separator: "/").last {
				return String(fileNameComponent)
			} else {
				return String(describing: fileName)
			}
		}()

		let string = logFormat.format(
			string: message,
			level: level,
			dateFormat: dateFormat,
			functionName: String(describing: functionName),
			fileName: fileName,
			lineNumber: lineNumber
		)

		destinations
			.filter({ $0.outputLevel <= level })
			.forEach({ destination in
				destination.process(
					string: string,
					level: level
				)
			})
	}

	public func addDestination(_ destination: LoggerDestinationProtocol) {
		destinations.append(destination)
	}

}
