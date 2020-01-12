//
//  UIEdgeInsets+Inits.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 28.12.19.
//  Copyright © 2019 Pavlin Panayotov. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
	init(inset: CGFloat) {
		self.init(
			vertical: inset,
			horizontal: inset
		)
	}
	
	init(vertical: CGFloat, horizontal: CGFloat) {
		self.init(
			top: vertical,
			left: horizontal,
			bottom: vertical,
			right: horizontal
		)
	}
}
