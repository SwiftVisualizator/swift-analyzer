//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 12.05.2023.
//

import Foundation

public let log: LoggerProtocol = {
	let logger = DefaultLogger()
	logger.isEnabled = true
	logger.addDestination(DefaultConsoleDestination(outputLevel: .verbose))
	return logger
}()
