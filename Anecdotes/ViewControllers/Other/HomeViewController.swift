//
//  HomeViewController.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 12.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class HomeViewController: TableViewController {
	
	private let anecdote = DataManager.shared.dailyAnecdote
	private let tableHeaderView: UIView = {
		let view = UIView()
		let label = UILabel()
		label.textAlignment = .center
		label.text = "Анекдот на деня"
		view.addFullSizedSubview(
			label,
			topPadding: 10,
			trailingPadding: 20,
			bottomPadding: 10,
			leadingPadding: 20
		)
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Начало"
	}
	
	// MARK: - Overrides
	override func setupTableView() {
		super.setupTableView()
		
		tableView.register(cellType: AnecdoteTableViewCell.self)
		tableView.tableHeaderView = tableHeaderView
		tableView.tableHeaderView?.frame.size.height = 40
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
