//
//  Anecdote.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 12.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

final class Anecdote {

	let creationDate: Date = .now
	let author: String = "None"
	let text: String = """
На конкурс между мъже “Какво е смесено чувство” победил мъжът, който отговорил:
- Това е, когато гледаш как твоята тъща лети в пропастта с твоята кола.
"""
	let raiting: Double = 3.7
	let raitingsCount: Int = 5
	let isRated: Bool = false
}
