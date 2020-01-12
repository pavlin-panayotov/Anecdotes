//
//  DetailsTableViewCell.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 27.12.19.
//  Copyright © 2019 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class DetailsTableViewCell: TableViewCell {
	
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var valueLabel: UILabel!
	@IBOutlet private weak var contentStackView: UIStackView!
	
	/// Default `.left`.
	var textsAlignment: NSTextAlignment = .left {
		didSet {
			textAlignmentChanged(oldValue: oldValue)
		}
	}
	
	// Default `5`.
	var subviewsSpacing: CGFloat {
		get { contentStackView.spacing }
		set { contentStackView.spacing = newValue }
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		subviewsSpacing = 5
		titleLabel.font = UIFont.systemFont(ofSize: 16)
		valueLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
		
		textAlignmentChanged(oldValue: nil)
	}
	
	// MARK: - Private
	private func textAlignmentChanged(oldValue: NSTextAlignment?) {
		guard textsAlignment != oldValue else {
			return
		}
		
		titleLabel.textAlignment = textsAlignment
		valueLabel.textAlignment = textsAlignment
	}
	
	// MARK: - Public
	func config(title: String?, value: String?) {
		titleLabel.text = title
		valueLabel.text = value
		
		titleLabel.isHidden = titleLabel.text?.isEmpty != false
		valueLabel.isHidden = valueLabel.text?.isEmpty != false
	}
}
