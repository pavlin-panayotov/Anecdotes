//
//  LoadingViewController.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 11.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class LoadingViewController: ViewController {
	
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		activityIndicator.startAnimating()
		titleLabel.text = "Зареждане.."
	}
}
