//
//  File.swift
//  
//
//  Created by Roman Nabiullin on 31.01.2023.
//

import Foundation

// MARK: - Range

extension Node {
	
	/// Node range in a file.
	public struct Range {
		
		/// Node start row.
		public var startRow: Int
		
		/// Node start column.
		public var startColumn: Int
		
		/// Node end row.
		public var endRow: Int
		
		/// Node end column.
		public var endColumn: Int
		
	}
	
}
