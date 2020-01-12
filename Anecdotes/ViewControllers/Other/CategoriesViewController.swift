//
//  CategoriesViewController.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 12.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class CategoriesViewController: TableViewController {
	
	private var categories: [Category] {
		return DataManager.shared.categories
	}
	
	override init() {
		super.init()
		
		title = "Категории"
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Overrides
	override func setupTableView() {
		super.setupTableView()
		
		tableView.register(cellType: CategoryTableViewCell.self)
		tableView.rowHeight = CategoryTableViewCell.height
		tableView.estimatedRowHeight = CategoryTableViewCell.height
	}
	
	// MARK: - UITableViewDataSource
	override func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int) -> Int {
		
		return categories.count
	}
	
	override func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell() as CategoryTableViewCell
		
		if let category = categories[safe: indexPath.row] {
			cell.config(category: category)
		}
		
		return cell
	}
	
	// MARK: - UITableViewDelegate
	func tableView(
		_ tableView: UITableView,
		didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath, animated: true)
		
		guard let category = categories[safe: indexPath.row] else {
			return
		}
		
		navigationController?.pushViewController(
			AnecdotesViewController(anecdotes: category.anecdotes),
			animated: true
		)
	}
}
