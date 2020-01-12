//
//  UIStackView+Subviews.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 28.12.19.
//  Copyright © 2019 Pavlin Panayotov. All rights reserved.
//

import UIKit

extension UIStackView {
	func addArrangedSubviews(_ subviews: UIView...) {
		addArrangedSubviews(subviews)
	}
	
	func addArrangedSubviews(_ subviews: [UIView]) {
		subviews.forEach { addArrangedSubview($0) }
	}
}
