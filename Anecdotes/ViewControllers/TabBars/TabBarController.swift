//
//  TabBarController.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 12.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewControllers = [
			NavigationController(rootViewController: HomeViewController()),
			createController(),
			NavigationController(rootViewController: AboutUsViewController())
		]
	}
	
	// MARK: - Private
	private func createController() -> UIViewController {
		let controller = ViewController()
		controller.view.backgroundColor = .green
		controller.title = "Test"
		return controller
	}
}

