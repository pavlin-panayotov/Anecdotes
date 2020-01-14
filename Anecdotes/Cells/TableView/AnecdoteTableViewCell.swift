//
//  AnecdoteTableViewCell.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 12.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

protocol AnecdoteTableViewCellDelegate: class {
	func anecdoteTableViewCellDidTapRateButton(_ cell: AnecdoteTableViewCell)
}

final class AnecdoteTableViewCell: TableViewCell {
	
	@IBOutlet private weak var anecdoteLabel: UILabel!
	@IBOutlet private weak var authorLabel: UILabel!
	@IBOutlet private weak var creationDateLabel: UILabel!
	@IBOutlet private weak var ratingsLabel: UILabel!
	@IBOutlet private weak var myRatingLabel: UILabel!
	@IBOutlet private weak var rateButton: UIButton!
	
	weak var delegate: AnecdoteTableViewCellDelegate?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		rateButton.setTitle("Оцени", for: .normal)
	}
	
	// MARK: - Actions
	@IBAction func rateButtonTapped(_ sender: Any) {
		delegate?.anecdoteTableViewCellDidTapRateButton(self)
	}
	
	// MARK: - Private
	private func formatDate(_ date: Date) -> String {
		return DateFormatterManager.shared.displayDateFormatter.string(from: date)
	}
	
	// MARK: - Public
	func config(
		text: String,
		author: String,
		creationDate: Date,
		rating: Double,
		ratingsCount: Int,
		myRating: Int?) {
		
		anecdoteLabel.text = text
		authorLabel.text = "Автор: \(author)"
		creationDateLabel.text = "Дата на създаване: \(formatDate(creationDate))"
		ratingsLabel.text = "Оценка \(String(double: rating, precision: 2)) (\(ratingsCount))"
		myRatingLabel.text = {
			guard let myRating = myRating else {
				return nil
			}
			
			return "Моята оценка: \(myRating)"
		}()
		myRatingLabel.isHidden = myRatingLabel.text == nil
	}
}

// MARK: - Custom configs
extension AnecdoteTableViewCell {
	func config(anecdote: Anecdote) {
		config(
			text: anecdote.text,
			author: anecdote.author,
			creationDate: anecdote.creationDate,
			rating: anecdote.rating,
			ratingsCount: anecdote.ratingsCount,
			myRating: anecdote.myRating
		)
	}
}
