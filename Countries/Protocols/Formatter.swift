//
//  Formatter.swift
//  Countries
//
//  Created by Vladimir Budniy on 12/27/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import Foundation

struct Number {
    static let formatterWithSepator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = NumberFormatter.Style.decimal
        return formatter
    }()
}

extension Integer {
    var stringFormatedWithSepator: String {
        return Number.formatterWithSepator.string(from: self as! NSNumber) ?? ""
    }
}
