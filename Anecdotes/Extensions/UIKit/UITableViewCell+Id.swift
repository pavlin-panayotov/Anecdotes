//
//  UITableViewCell+Id.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 27.12.19.
//  Copyright © 2019 Pavlin Panayotov. All rights reserved.
//

import UIKit

extension UITableViewCell {
	static var identifier: String {
		return String(describing: self)
	}
}
