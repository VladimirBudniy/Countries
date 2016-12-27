//
//  ParsingModel.swift
//  Countries
//
//  Created by Vladimir Budniy on 12/23/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import Foundation
import CoreData

class ParsingModel {
    
//    static func parsJSONCountries(json: Array<Any>) -> Array<Country> {
//        let array = json[1] as! Array<Dictionary<String, Any>>
//        let context = DatabaseController.getContext()
//        let entityName:String = String(describing: Country.self)
//        for dictionary in array {
//            let capital = dictionary["capitalCity"] as! String?  /// костыль!!!!!!!!!!!! ////////////////////////////////////////////////
//            if capital != "" {
//                let country = DatabaseController.createEntityIn(context: context, name: entityName) as! Country
//                country.countrieName = dictionary["name"] as! String?
//                country.capitalCity = dictionary["capitalCity"] as! String?
//            }
//        }
//        DatabaseController.saveContext()
//
//        return DatabaseController.fetchEntityIn(context: context, type: Country.self)
//    }
    
    static func parsJSONCountries(json: Array<Any>) -> Array<Country> {
        let array = json as! Array<Dictionary<String, Any>>
        let context = DatabaseController.getContext()
        let entityName:String = String(describing: Country.self)
        for dictionary in array {
            let country = DatabaseController.createEntityIn(context: context, name: entityName) as! Country
            country.countrieName = dictionary["name"] as! String?
            country.capitalCity = dictionary["capital"] as! String?
            country.nativeName = dictionary["nativeName"] as! String?
            country.populationQty = dictionary["population"] as! Int64
            country.regionName = dictionary["region"] as! String?
            
            let arrayTimezones = dictionary["timezones"] as! Array<String>
            country.timezones = arrayTimezones.joined(separator: " ")
            
            let arrayCurrencies = dictionary["timezones"] as! Array<String>
            country.currencies = arrayCurrencies.joined(separator: " ")
        }
        DatabaseController.saveContext()
        
        return DatabaseController.fetchEntityIn(context: context, type: Country.self)
    }
    
}
