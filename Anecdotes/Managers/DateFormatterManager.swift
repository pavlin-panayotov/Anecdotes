//
//  DateFormatterManager.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 12.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

struct DateFormatterManager {
	
	static let shared = DateFormatterManager()
	
	let responseDateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd-MM-yyyy"
		return dateFormatter
	}()
	
	let displayDateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd.MM.yyyy г."
		return dateFormatter
	}()
}
