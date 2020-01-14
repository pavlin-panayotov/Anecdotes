//
//  CategoriesViewController.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 12.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class CategoriesViewController: TableViewController {
	
	private lazy var tableFooterView: UIView = {
		let view = UIView()
		let button = UIButton()
		button.setTitle("Случаен анекдот", for: .normal)
		button.setTitleColor(.systemBlue, for: .normal)
		button.setTitleColor(UIColor.systemBlue.withAlphaComponent(0.5), for: .highlighted)
		button.addTarget(
			self,
			action: #selector(showRandomAnecdote),
			for: .touchUpInside
		)
		view.addFullSizedSubview(
			button,
			topPadding: 10,
			trailingPadding: 20,
			bottomPadding: 10,
			leadingPadding: 20
		)
		return view
	}()
	
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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		tableView.reloadData()
	}
	
	// MARK: - Overrides
	override func setupTableView() {
		super.setupTableView()
		
		tableView.register(cellType: CategoryTableViewCell.self)
		tableView.rowHeight = CategoryTableViewCell.height
		tableView.estimatedRowHeight = CategoryTableViewCell.height
		tableView.tableFooterView = tableFooterView
		tableView.tableFooterView?.frame.size.height = 50
	}
	
	// MARK: - Actions
	@objc
	private func showRandomAnecdote(_ sender: Any) {
		guard categories.isEmpty == false else {
			return
		}
		
		let randomCategory = categories[Int.random(in: 0..<categories.count)]
		
		guard randomCategory.anecdotes.isEmpty == false else {
			return
		}
		
		let randomAnecdote = randomCategory.anecdotes[Int.random(in: 0..<randomCategory.anecdotes.count)]
		navigationController?.pushViewController(
			AnecdotesViewController(anecdotes: [randomAnecdote]),
			animated: true
		)
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
