//
//  Array+Elements.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 27.12.19.
//  Copyright © 2019 Pavlin Panayotov. All rights reserved.
//

import Foundation

extension Array {
	subscript(safe index: Index) -> Element? {
		guard index >= startIndex && index < endIndex else {
			return nil
		}
		
		return self[index]
	}
}
