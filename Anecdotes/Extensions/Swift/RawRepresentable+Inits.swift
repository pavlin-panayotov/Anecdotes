//
//  RawRepresentable+Inits.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 10.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

extension RawRepresentable {
	init?(optionalRawValue: RawValue?) {
		guard let rawValue = optionalRawValue else {
			return nil
		}
		
		self.init(rawValue: rawValue)
	}
}
