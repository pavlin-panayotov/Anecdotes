//
//  AboutUsViewController.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 7.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class AboutUsViewController: TableViewController {
	
	private enum Row {
		case dataSource
		case appSource
		case newAnecdote
		case version
		
		var title: String {
			switch self {
			case .dataSource:
				return "Източник на информацията"
			case .appSource:
				return "Източник на приложението"
			case .newAnecdote:
				return "Добави анекдот"
			case .version:
				return "Версия"
			}
		}
		
		var value: String? {
			switch self {
			case .dataSource, .appSource, .newAnecdote:
				return nil
			case .version:
				return "1.0"
			}
		}
		
		var cellSelectionStyle: UITableViewCell.SelectionStyle {
			switch self {
			case .dataSource, .appSource, .newAnecdote:
				return .default
			case .version:
				return .none
			}
		}
		
		var textsAlignment: NSTextAlignment {
			switch self {
			case .dataSource, .appSource, .newAnecdote:
				return .left
			case .version:
				return .center
			}
		}
	}
	
	private let dataSource: [Row] = [
		.dataSource,
		.appSource,
		.newAnecdote,
		.version,
	]
	
	override init() {
		super.init()
		
		title = "За нас"
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Overrides
	override func setupTableView() {
		super.setupTableView()
		
		tableView.register(cellType: DetailsTableViewCell.self)
	}
	
	// MARK: - UITableViewDataSource
	override func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int) -> Int {
		
		return dataSource.count
	}
	
	override func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell() as DetailsTableViewCell
		
		if let row = dataSource[safe: indexPath.row] {
			cell.selectionStyle = row.cellSelectionStyle
			cell.textsAlignment = row.textsAlignment
			cell.config(
				title: row.title,
				value: row.value
			)
		}
		
		return cell
	}
	
	// MARK: - UITableViewDelegate
	func tableView(
		_ tableView: UITableView,
		didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath, animated: true)
		
		guard let row = dataSource[safe: indexPath.row] else {
			return
		}
		
		switch row {
		case .dataSource:
			UIApplication.shared.open(
				Constant.Url.dataSource,
				options: [:],
				completionHandler: nil
			)
			
		case .appSource:
			UIApplication.shared.open(
				Constant.Url.appSource,
				options: [:],
				completionHandler: nil
			)
			
		case .newAnecdote:
			navigationController?.pushViewController(
				CreateAnecdoteViewController(),
				animated: true
			)
			
		case .version:
			break
		}
	}
}
