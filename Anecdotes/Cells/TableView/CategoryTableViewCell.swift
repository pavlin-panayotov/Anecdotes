//
//  CategoryTableViewCell.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 7.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class CategoryTableViewCell: TableViewCell {
	
	static let height: CGFloat = 44
	
	@IBOutlet private weak var titleLabel: UILabel!
	
	// MARK: - Public
	func config(title: String, count: Int) {
		titleLabel.text = "\(title) (\(count))"
	}
}

// MARK: - Custom configs
extension CategoryTableViewCell {
	func config(category: Category) {
		config(
			title: category.name,
			count: category.anecdotes.count
		)
	}
}
