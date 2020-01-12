//
//  UITableView+Cells.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 27.12.19.
//  Copyright © 2019 Pavlin Panayotov. All rights reserved.
//

import UIKit

extension UITableView {
	func dequeueReusableCell<T: UITableViewCell>() -> T {
		return dequeueReusableCell(withIdentifier: T.identifier) as! T
	}
	
	func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
		return dequeueReusableCell(
			withIdentifier: T.identifier,
			for: indexPath
		) as! T
	}
	
	func register(cellType: UITableViewCell.Type) {
		register(
			UINib(nibName: String(describing: cellType), bundle: nil),
			forCellReuseIdentifier: cellType.identifier
		)
	}
}
