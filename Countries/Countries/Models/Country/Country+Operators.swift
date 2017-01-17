//
//  Country+Operators.swift
//  Countries
//
//  Created by Vladimir Budniy on 1/10/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

infix operator ~~
infix operator ~+~

public func ~+~<T>(JSONObject: Any?, object: String) -> T? {
    if let JSON = JSONObject as? [String: Any] {
        
        let value = JSON[object]
        if let result = value as? Array<String> {
            return result.joined(separator: " ") as? T
            
        } else if let result = value as? Array<Int> {
            
            let value = result.flatMap({ String($0) })
            return value.joined(separator: " ") as? T
        } else {
            return value as? T
        }
    }
    
    return object as? T
}

public func ~~ <T>(left: inout T?, right: Any?) {
    left = right as? T
    
    
    
    
//    switch right.mappingType {
//    case .fromJSON where right.isKeyPresent:
//        FromJSON.basicType(&left, object: right.value())
//    case .toJSON:
//        left >>> right
//    default: ()
//    }
}
