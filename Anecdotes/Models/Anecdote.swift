//
//  Anecdote.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 12.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

final class Anecdote {

	let text: String
	let author: String
	let creationDate: Date
	private(set) var rating: Double
	private(set) var ratingsCount: Int
	private var myRating: Int?
	
	var isRated: Bool {
		return myRating != nil
	}
	
	init?(rawModel: RawAnecdote) {
		let text = rawModel.text
		
		guard
			text.isEmpty == false,
			let author = rawModel.author,
			let creationDate = rawModel.creationDate,
			let rating = rawModel.rating,
			let ratingsCount = rawModel.ratingsCount
			else {
				return nil
		}
		
		self.text = text
		self.author = author
		self.creationDate = creationDate
		self.rating = rating
		self.ratingsCount = ratingsCount
		self.myRating = rawModel.myRating
	}
	
	// MARK: - Public
	func add(newRating: Int) {
		let oldRatingsCount = ratingsCount
		
		if isRated == false {
			ratingsCount += 1
		}
		
		let sumUpOldRatings = rating * Double(oldRatingsCount)
		let ratingDifference = newRating - (myRating ?? 0)
		rating = (sumUpOldRatings + Double(ratingDifference)) / Double(ratingsCount)
		myRating = newRating
	}
}
