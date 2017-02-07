//
//  Country+Parser.swift
//  Countries
//
//  Created by Vladimir Budniy on 2/2/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import MagicalRecord
import ObjectMapper

enum dataType {
    case countries
    case country
}

typealias parseDataType = dataType

extension Country {

    static func parsJSON(json: [Dictionary<String, Any>]?) {
        var result: [Country]?
        MagicalRecord.save({ context in
            if let array = json {
                let mapContext = CountryMapContext(context: context)
                result = Mapper<Country>(context: mapContext).mapArray(JSONArray: array)
//                print(result as Any)
            }
        }, completion: { success, error in
            if error == nil {
                print(result as Any)
            }
        })
    }
}
