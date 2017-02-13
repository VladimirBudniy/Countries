//
//  Transform.swift
//  Countries
//
//  Created by Vladimir Budniy on 2/7/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import ObjectMapper

class StringFromArrayTransform: TransformType {
    typealias Object = String
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> String? {
        if let value = value as? [String] {
            return value.joined(separator: ", ")
        } else if let value = value as? [Int] {
            let result = value.flatMap({ String($0) })
            
            return result.joined(separator: ", ")
        } else if let value = value as? [String: Any] {
            let keys = Array(value.keys)
            var array = [String]()
            for key in keys {
                array.append("\(key) = \(value[key]!)")
            }
            
            return array.joined(separator: ", ")
        } else {
            return nil
        }
    }
    
    func transformToJSON(_ value: Object?) -> JSON? {
        return nil
    }
}
