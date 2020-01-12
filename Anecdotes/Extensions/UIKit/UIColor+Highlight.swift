//
//  UIColor+Highlight.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 28.12.19.
//  Copyright © 2019 Pavlin Panayotov. All rights reserved.
//

import UIKit

extension UIColor {
	var highlighted: UIColor {
		return withAlphaComponent(0.5)
	}
}
