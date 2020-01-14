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
	
	init(anecdotes: [Anecdote], title: String? = nil) {
		self.anecdotes = anecdotes
		
		super.init()
		
		self.title = {
			if let title = title, title.isEmpty == false {
				return title
			}
			
			return anecdotes.count > 1 ? "Анекдоти" : "Анекдот"
		}()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		tableView.reloadData()
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

// MARK: - AnecdoteTableViewCellDelegate
extension AnecdotesViewController: AnecdoteTableViewCellDelegate {
	func anecdoteTableViewCellDidTapRateButton(_ cell: AnecdoteTableViewCell) {
		guard
			let indexPath = tableView.indexPath(for: cell),
			let anecdote = anecdotes[safe: indexPath.row]
			else {
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
