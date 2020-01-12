//
//  AnecdotesViewController.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 12.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class AnecdotesViewController: TableViewController {
	
	private let anecdotes: [Anecdote]
	
	init(anecdotes: [Anecdote]) {
		self.anecdotes = anecdotes
		
		super.init()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = anecdotes.isEmpty ? "Анекдот" : "Анекдоти"
	}
	
	// MARK: - Overrides
	override func setupTableView() {
		super.setupTableView()
		
		tableView.register(cellType: AnecdoteTableViewCell.self)
	}
	
	// MARK: - Private
	private func showRateSheetFor(anecdote: Anecdote) {
		let actionSheet = UIAlertController(
			title: "Избери оценка",
			message: nil,
			preferredStyle: .actionSheet
		)
		
		(1...5).forEach { rating in
			actionSheet.addAction(
				UIAlertAction(
					title: "\(rating)",
					style: .default,
					handler: { [weak self, weak anecdote] _ in
						anecdote?.add(newRating: rating)
						self?.tableView.reloadData()
				})
			)
		}
		
		actionSheet.addAction(
			UIAlertAction(
				title: "Откажи",
				style: .cancel,
				handler: nil
			)
		)
		
		present(actionSheet, animated: true, completion: nil)
	}
	
	// MARK: - UITableViewDataSource
	override func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int) -> Int {
		
		return anecdotes.count
	}
	
	override func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell() as AnecdoteTableViewCell
		cell.delegate = self
		cell.selectionStyle = .none
		
		if let anecdote = anecdotes[safe: indexPath.row] {
			cell.config(anecdote: anecdote)
		}
		
		return cell
	}
}

extension AnecdotesViewController: AnecdoteTableViewCellDelegate {
	func anecdoteTableViewCellDidTapRateButton(_ cell: AnecdoteTableViewCell) {
		guard
			let indexPath = tableView.indexPath(for: cell),
			let anecdote = anecdotes[safe: indexPath.row]
			else {
				return
		}
		
		showRateSheetFor(anecdote: anecdote)
	}
}
