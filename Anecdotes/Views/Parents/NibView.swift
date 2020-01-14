//
//  NibView.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 8.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

class NibView: UIView {
	
	private(set) var nibView: UIView!
	
	override var backgroundColor: UIColor? {
		didSet {
			nibView?.backgroundColor = backgroundColor
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		loadNibView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
		loadNibView()
	}
	
	// MARK: - Private
	private func loadNibView() {
		let nibContent = Bundle.main.loadNibNamed(
			String(describing: type(of: self)),
			owner: self,
			options: nil
		)
		
		nibView = (nibContent?.first as! UIView)
		nibView.backgroundColor = backgroundColor
		addFullSizedSubview(nibView)
		
		initialSetup()
	}
	
	// MARK: - Public
	func initialSetup() {
		
	}
}
