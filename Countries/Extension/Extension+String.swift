//
//  Extension+String.swift
//  Countries
//
//  Created by Vladimir Budniy on 1/20/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

extension String {
    func doubleValue() -> Double? {
        let double = NumberFormatter().number(from: self)?.doubleValue
        return double
    }
}
