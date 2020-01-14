//
//  ScrollViewController.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 28.12.19.
//  Copyright © 2019 Pavlin Panayotov. All rights reserved.
//

import UIKit

class ScrollViewController: ViewController {
	
	@IBOutlet private(set) weak var scrollView: UIScrollView!
	@IBOutlet private weak var scrollContentView: UIView!
	@IBOutlet private weak var scrollContentStackView: UIStackView!
	
	// Default `20`.
	var spacing: CGFloat {
		get { scrollContentStackView.spacing }
		set { scrollContentStackView.spacing = newValue }
	}
	
	// Default `.zero`.
	var scrollSubviewsInsets: UIEdgeInsets {
		get { scrollContentView.layoutMargins }
		set { scrollContentView.layoutMargins = newValue }
	}
	
	init() {
		super.init(
			nibName: String(describing: ScrollViewController.self),
			bundle: nil
		)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupScrollView()
	}
	
	// MARK: - Public
	func setupScrollView() {
		
	}
	
	func addScrollSubviews(_ subviews: UIView...) {
		scrollContentStackView.addArrangedSubviews(subviews)
	}
}
