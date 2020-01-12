//
//  HomeViewController.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 12.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class HomeViewController: TableViewController {
	
	private let anecdote = DataManager.shared.categories.first?.anecdotes.first
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Начало"
	}
	
	// MARK: - Overrides
	override func setupTableView() {
		super.setupTableView()
		
		tableView.register(cellType: AnecdoteTableViewCell.self)
	}
	
	// MARK: - UITableViewDataSource
	override func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int) -> Int {
		
		return anecdote == nil ? 0 : 1
	}
	
	override func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell() as AnecdoteTableViewCell
		cell.delegate = self
		cell.selectionStyle = .none
		
		if let anecdote = anecdote {
			cell.config(anecdote: anecdote)
		}
		
		return cell
	}
}

// MARK: - AnecdoteTableViewCellDelegate
extension HomeViewController: AnecdoteTableViewCellDelegate {
	func anecdoteTableViewCellDidTapRateButton(_ cell: AnecdoteTableViewCell) {
		guard let anecdote = anecdote else {
			return
		}
		
		NavigationManager.shared.showRateSheetFor(
			sender: self,
			anecdote: anecdote,
			completion: { [weak self] in
				self?.tableView.reloadData()
		})
	}
}
