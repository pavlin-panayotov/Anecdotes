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
	let id: String
	let author: String
	let creationDate: Date
	private(set) var rating: Double
	private(set) var ratingsCount: Int
	private(set) var myRating: Int?
	
	var isRated: Bool {
		return myRating != nil
	}
	
	init?(rawModel: RawAnecdote) {
		let text = rawModel.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		
		guard
			text.isEmpty == false,
			let id = rawModel.id,
			let author = rawModel.author,
			let creationDate = rawModel.creationDate,
			let rating = rawModel.rating,
			let ratingsCount = rawModel.ratingsCount
			else {
				return nil
		}
		
		self.text = text
		self.id = id
		self.author = author
		self.creationDate = creationDate
		self.rating = rating
		self.ratingsCount = ratingsCount
		self.myRating = rawModel.myRating
	}
	
	init(text: String, author: String) {
		self.text = text
		self.id = "A\(author)\(Int(Date.now.timeIntervalSince1970))"
		self.author = author
		self.creationDate = .now
		self.rating = 0
		self.ratingsCount = 0
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

// MARK: - XmlRepresentable
extension Anecdote: XmlRepresentable {
	var xmlString: String {
		let myRatingString = { () -> String in
			guard let myRating = myRating else {
				return ""
			}
			
			return " myRating=\"\(myRating)\""
		}()
		
		let template = """
		<anecdote id="\(id)" author="\(author)" creationDate="\(DateFormatterManager.shared.responseDateFormatter.string(from: creationDate))" rating="\(String(double: rating, precision: 2))" ratingsCount="\(ratingsCount)"\(myRatingString)>
\(text)
		</anecdote>
"""
		
		return template
	}
}
