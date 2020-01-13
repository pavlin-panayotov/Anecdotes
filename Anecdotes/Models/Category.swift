//
//  Category.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 12.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

final class Category {
	
	private(set) var anecdotes: [Anecdote] = []
	let name: String
	private let id: String
	
	init?(rawModel: RawCategory) {
		guard
			let name = rawModel.name,
			let id = rawModel.id
			else {
				return nil
		}
		
		let anecdotes = rawModel.anecdotes.compactMap { Anecdote(rawModel: $0) }
		
		guard anecdotes.isEmpty == false else {
			return nil
		}
		
		self.anecdotes = anecdotes
		self.name = name
		self.id = id
	}
}

// MARK: - XmlRepresentable
extension Category: XmlRepresentable {
	var xmlString: String {
		let anecdotesString = anecdotes.reduce(into: "") { (result, anecdote) in
			if result.isEmpty {
				result = anecdote.xmlString
			} else {
				result += "\n\(anecdote.xmlString)"
			}
		}
		
		let template = """
	<category id="\(id)" title="\(name)">
\(anecdotesString)
	</category>
"""
		
		return template
	}
}
