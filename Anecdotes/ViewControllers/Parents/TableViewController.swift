//
//  TableViewController.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 27.12.19.
//  Copyright © 2019 Pavlin Panayotov. All rights reserved.
//

import UIKit

class TableViewController: ViewController, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet private(set) weak var tableView: UITableView!
	
	private lazy var noDataLabel: UILabel = {
		let label = UILabel()
		label.text = "Няма данни"
		label.numberOfLines = 0
		label.textAlignment = .center
		label.isHidden = true
		return label
	}()
	
	init() {
		super.init(
			nibName: String(describing: TableViewController.self),
			bundle: nil
		)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupTableView()
	}
	
	// MARK: - Public
	func setupTableView() {
		tableView.addEmptyFooterView()
	}
	
	func showNoDataLabel() {
		if noDataLabel.superview == nil {
			view.addFullSizedSubview(noDataLabel)
		}
		
		noDataLabel.isHidden = false
	}
	
	func hideNoDataLabel() {
		noDataLabel.isHidden = true
	}
	
	// MARK: - UITableViewDataSource
	func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int) -> Int {
		
		return 0
	}
	
	func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		return UITableViewCell()
	}
}
