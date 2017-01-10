//
//  Country+Operators.swift
//  Countries
//
//  Created by Vladimir Budniy on 1/10/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

infix operator ~~
infix operator ~~~

public func ~~<T>(left: Dictionary<String, Any>, right: String) -> T {
    let value = left[right]
    
    return value as! T
}

public func ~~~(left: Dictionary<String, Any>, right: String) -> String {
    let value: Array<String> = left[right] as! Array<String>
    
    return value.joined(separator: " ")
}
