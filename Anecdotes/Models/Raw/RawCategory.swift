//
//  RawCategory.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 13.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

final class RawCategory: RawXmlObjectProtocol {
	
	private(set) var anecdotes: [RawAnecdote] = []
	let name: String?
	let id: String?
	
	init(attributeDict: [String: String]) {
		self.name = attributeDict["title"] ?? ""
		self.id = attributeDict["id"] ?? ""
	}
	
	// MARK: - Public
	func append(anecdote: RawAnecdote) {
		anecdotes.append(anecdote)
	}
}
