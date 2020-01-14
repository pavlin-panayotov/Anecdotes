//
//  NavigationManager.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 12.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class NavigationManager {
	
	static let shared = NavigationManager()
	
	// MARK: - Public
	func showRateSheetFor(
		sender: UIViewController,
		anecdote: Anecdote,
		completion: @escaping VoidClosure) {
		
		let actionSheet = UIAlertController(
			title: "Избери оценка",
			message: nil,
			preferredStyle: .actionSheet
		)
		
		Constant.Config.ratingsRange.forEach { rating in
			actionSheet.addAction(
				UIAlertAction(
					title: "\(rating)",
					style: .default,
					handler: { [weak anecdote] _ in
						anecdote?.add(newRating: rating)
						DataManager.shared.saveCategories()
						completion()
				})
			)
		}
		
		actionSheet.addAction(
			UIAlertAction(
				title: "Откажи",
				style: .cancel,
				handler: nil
			)
		)
		
		sender.present(actionSheet, animated: true, completion: nil)
	}
}
