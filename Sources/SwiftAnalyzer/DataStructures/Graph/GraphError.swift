//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 08.02.2023.
//

import Foundation

// MARK: - Error

enum GraphError: UInt8, Error {
	
	case noSuchVertex
	
	case noSuchEdge
	
	case vertexIsAlreadyInGraph
	
	case edgeIsAlreadyInGraph
	
}
