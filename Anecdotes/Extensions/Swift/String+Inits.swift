//
//  String+Inits.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 8.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

extension String {
	init(float: Float, precision: Int) {
		self.init(format: "%.\(precision)f", float)
	}
	
	init(double: Double, precision: Int) {
		self.init(format: "%.\(precision)f", double)
	}
	
	init(int: Int, precision: Int) {
		self.init(format: "%.\(precision)f", int)
	}
}
