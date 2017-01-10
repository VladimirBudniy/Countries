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
            country.countrieName = dictionary~~"name"
            country.capitalCity = dictionary~~"capital"
            country.nativeName = dictionary~~"nativeName"
            country.populationQty = dictionary~~"population"
            country.regionName = dictionary~~"region"
            country.timezones = dictionary~~~"timezones"
            country.currencies = dictionary~~~"currencies"
        }
        
        DatabaseController.sharedInstance.saveWithContext(context: context)
    }
    
}
