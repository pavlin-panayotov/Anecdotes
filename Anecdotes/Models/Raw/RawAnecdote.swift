//
//  RawAnecdote.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 13.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

final class RawAnecdote: RawXmlObjectProtocol {
	
	/// **Note**: Text may contain leading or trailing new lines. Better trim before usage.
	var text = ""
	let id: String?
	let author: String?
	let creationDate: Date?
	let rating: Double?
	let ratingsCount: Int?
	let myRating: Int?
	
	init(attributeDict: [String: String]) {
		id = attributeDict["id"]
		author = attributeDict["author"]
		creationDate = Self.parseDateFrom(dict: attributeDict, for: "creationDate")
		rating = Self.parseDoubleFrom(dict: attributeDict, for: "rating")
		ratingsCount = Self.parseIntFrom(dict: attributeDict, for: "ratingsCount")
		myRating = Self.parseIntFrom(dict: attributeDict, for: "myRating")
	}
}
