//
//  Category.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 12.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

final class Category {
	
	let anecdotes: [Anecdote] = Array(repeating: Anecdote(), count: 11)
	let name: String = "Категория"
	
	init() {
		
	}
}
