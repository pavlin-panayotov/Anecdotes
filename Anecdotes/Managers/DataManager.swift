//
//  DataManager.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 12.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

final class DataManager {
	
	static let shared = DataManager()
	
	private(set) var categories: [Category] = Array(repeating: Category(), count: 6)
	
	private func loadData() {
		
	}
	
	// MARK: - Public
	func loadData(completion: @escaping VoidClosure) {
		DispatchQueue.global().async { [unowned self] in
			self.loadData()
			
			DispatchQueue.main.async {
				completion()
			}
		}
	}
}
