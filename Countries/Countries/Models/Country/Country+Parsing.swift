//
//  Country+Parsing.swift
//  Countries
//
//  Created by Vladimir Budniy on 1/6/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

extension Country {
    
    static func parsJSONCountriesDetails(json: Array<Any>) {
        let array = json as! Array<Dictionary<String, Any>>
        let context = DatabaseController.sharedInstance.getBackgroundContext()
        let entityName:String = String(describing: Country.self)
        for dictionary in array {
            let country = DatabaseController.sharedInstance.createEntityIn(context: context, name: entityName) as! Country
            country.countrieName = dictionary["name"] as? String
            country.capitalCity = dictionary["capital"] as? String
            country.nativeName = dictionary["nativeName"] as? String
            country.populationQty = dictionary["population"] as! Int64
            country.regionName = dictionary["region"] as? String
            
            let arrayTimezones = dictionary["timezones"] as! Array<String>
            country.timezones = arrayTimezones.joined(separator: " ")
            
            let arrayCurrencies = dictionary["timezones"] as! Array<String>
            country.currencies = arrayCurrencies.joined(separator: " ")
        }
        
        DatabaseController.sharedInstance.saveWithContext(context: context)
    }
    
}
