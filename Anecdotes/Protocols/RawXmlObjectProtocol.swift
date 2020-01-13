//
//  RawXmlObject.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 13.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

protocol RawXmlObjectProtocol {
	init(attributeDict: [String: String])
}

extension RawXmlObjectProtocol {
	static func parseIntFrom(dict: [String: String], for key: String) -> Int? {
		guard let stringValue = dict[key] else {
				return nil
		}
		
		return Int(stringValue)
	}
	
	static func parseDoubleFrom(dict: [String: String], for key: String) -> Double? {
		guard let stringValue = dict[key] else {
			return nil
		}
		
		return Double(stringValue)
	}
	
	static func parseDateFrom(dict: [String: String], for key: String) -> Date? {
		guard let stringValue = dict[key] else {
			return nil
		}
		
		return DateFormatterManager.shared.responseDateFormatter.date(from: stringValue)
	}
}
