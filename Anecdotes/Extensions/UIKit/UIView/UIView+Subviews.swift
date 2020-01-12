//
//  UIView+Subviews.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 8.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

extension UIView {
	
	// MARK: - Add
	func addFullSizedSubview(
		_ view: UIView,
		topPadding: CGFloat = 0,
		trailingPadding: CGFloat = 0,
		bottomPadding: CGFloat = 0,
		leadingPadding: CGFloat = 0) {
		
		addSubview(view)
		
		view.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate(
			view.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
			trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingPadding),
			bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomPadding),
			view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingPadding)
		)
	}
	
	// MARK: - Remove
	func removeSubviews() {
		subviews.forEach { $0.removeFromSuperview() }
	}
}
