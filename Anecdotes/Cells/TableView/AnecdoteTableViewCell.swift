//
//  AnecdoteTableViewCell.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 12.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class AnecdoteTableViewCell: TableViewCell {
	
	@IBOutlet private weak var anecdoteLabel: UILabel!
	@IBOutlet private weak var authorLabel: UILabel!
	@IBOutlet private weak var creationDateLabel: UILabel!
	
	// MARK: - Private
	private func formatDate(_ date: Date) -> String {
		return DateFormatterManager.shared.displayDateFormatter.string(from: date)
	}
	
	// MARK: - Public
	func config(text: String, author: String, creationDate: Date) {
		anecdoteLabel.text = text
		authorLabel.text = "Автор: \(author)"
		creationDateLabel.text = "Дата на създаване: \(formatDate(creationDate))"
	}
}

// MARK: - Custom configs
extension AnecdoteTableViewCell {
	func config(anecdote: Anecdote) {
		config(
			text: anecdote.text,
			author: anecdote.author,
			creationDate: anecdote.creationDate
		)
	}
}
