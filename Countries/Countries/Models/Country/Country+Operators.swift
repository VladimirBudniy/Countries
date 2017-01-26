//
//  Country+Operators.swift
//  Countries
//
//  Created by Vladimir Budniy on 1/10/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

infix operator ~   // return simple value
infix operator ~?  // return optional value

public func ~?<T>(JSONObject: [String: Any], object: String) -> T? {
    let value = JSONObject[object]
    
    if let result = value as? Array<String> {
        return compute(value: result)
    }
    
    if let result = value as? Array<Int> {
        return compute(value: result)
    }
    
    if let result = value as? Dictionary<String, Any> {
        return compute(value: result)
    }
    
    return compute(value: value)
}

public func ~<T>(JSONObject: [String: Any]?, object: String) -> T {
    let value = JSONObject?[object]
    return compute(value: value)!
}

// MARK: - Private

private func compute<T, U>(value: T) -> U? {
    let value = value
    
    return value as? U
}

private func compute<T>(value: Array<String>) -> T? {
    return value.joined(separator: ", ") as? T
}

private func compute<T>(value: Array<Int>) -> T? {
    let result = value.flatMap({ String($0) })
    
    return result.joined(separator: ", ") as? T
}

private func compute<T>(value: Dictionary<String, Any>) -> T? {
    let keys = Array(value.keys)
    var array = [String]()
    for key in keys {
        array.append("\(key) = \(value[key]!)")
    }

    return array.joined(separator: ", ") as? T
}
