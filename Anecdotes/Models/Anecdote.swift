//
//  Anecdote.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 12.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

final class Anecdote {

	let text: String = """
На конкурс между мъже “Какво е смесено чувство” победил мъжът, който отговорил:
- Това е, когато гледаш как твоята тъща лети в пропастта с твоята кола.
"""
	let author: String = "Неизвестен"
	let creationDate: Date = .now
	private(set) var rating: Double = 3.7
	private(set) var ratingsCount: Int = 6
	private var oldRating: Int? = 5
	
	var isRated: Bool {
		return oldRating != nil
	}
	
	// MARK: - Public
	func add(newRating: Int) {
		let oldRatingsCount = ratingsCount
		
		if isRated == false {
			ratingsCount += 1
		}
		
		let sumUpOldRatings = rating * Double(oldRatingsCount)
		let ratingDifference = newRating - (oldRating ?? 0)
		rating = (sumUpOldRatings + Double(ratingDifference)) / Double(ratingsCount)
		oldRating = newRating
	}
}
