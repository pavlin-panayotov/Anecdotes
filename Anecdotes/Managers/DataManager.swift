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
	
	private(set) var categories: [Category] = []
	
	private let fileName = "anecdotes.xml"
	
	private var fileDirectory: URL? {
		guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
			return nil
		}
		
		return url.appendingPathComponent(fileName)
	}
	
	init() {
		createFileOnDevice()
	}
	
	// MARK: - Private
	private func createFileOnDevice() {
		guard
			let fileUrl = fileDirectory,
			FileManager.default.fileExists(atPath: fileUrl.path) == false,
			let path = Bundle.main.path(forResource: "anecdotes", ofType: "xml"),
			let xmlString = try? String(contentsOfFile: path, encoding: .utf8)
			else {
				return
		}
		
		try? xmlString.write(to: fileUrl, atomically: false, encoding: .utf8)
	}
	
	private func loadData(completion: @escaping GetItemClosure<[Category]>) {
		guard
			let fileDirectory = fileDirectory,
			let parser = DataParser(fileUrl: fileDirectory) else {
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
	
	func saveCategories() {
		guard let fileUrl = fileDirectory else {
			return
		}
		
		let result = categories.reduce(into: "") { (result, category) in
			result += category.xmlString
		}
		
		let xmlString = """
<?xml version="1.0" encoding="UTF-8"?>
<categories>
\(result)
</categories>
"""
		
		try? xmlString.write(to: fileUrl, atomically: false, encoding: .utf8)
	}
}
