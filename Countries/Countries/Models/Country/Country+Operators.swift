//
//  Country+Operators.swift
//  Countries
//
//  Created by Vladimir Budniy on 1/10/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

infix operator ~
infix operator ~?
infix operator ~|
infix operator ~||


public func ~<T>(JSONObject: [String: Any], object: String) -> T? {
    let value = JSONObject[object]
    
    if let result = value as? Array<String> {
        return result.joined(separator: " ") as? T
    }
    
    if let result = value as? Array<Int> {
        let value = result.flatMap({ String($0) })
        return value.joined(separator: ", ") as? T
    }
    
    if let result = value as? Dictionary<String, Any> {
        let keys = Array(result.keys)
        var array = [String]()
        for key in keys {
            array.append("\(key) = \(result[key]!)")
        }
        
        let value = array.joined(separator: ", ")
        
        return value as? T
    }
    
    return value as? T
}

public func ~?<T>(JSONObject: [String: Any]?, object: String) -> T? {
    return nil
}

public func ~|<T>(JSONObject: [String: Any], object: String) -> T? {
    return nil
}

public func ~||<T>(JSONObject: [String: Any], object: String) -> T? {
    return nil
}
