//
//  DataManager.swift
//  Anecdotes
//
//  Created by Pavlin Panayotov on 12.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

final class DataManager: NSObject {
	
	static let shared = DataManager()
	
	private(set) var categories: [Category] = []
	
	private func loadData(completion: @escaping GetItemClosure<[Category]>) {
		guard let parser = DataParser(fileName: "anecdotes") else {
			completion([])
			return
		}
		
		parser.parse(completion: completion)
	}
	
	// MARK: - Public
	func loadData(completion: @escaping VoidClosure) {
		DispatchQueue.global().async { [unowned self] in
			self.loadData() { categories in
				DispatchQueue.main.async {
					self.categories = categories
					completion()
				}
			}
		}
	}
}
