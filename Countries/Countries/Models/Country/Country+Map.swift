//
//  Country+Map.swift
//  Countries
//
//  Created by Vladimir Budniy on 2/7/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import ObjectMapper
import MagicalRecord

extension Country: StaticMappable {
    
    // MARK: - StaticMappable
        
    public static func objectForMapping(map: Map) -> BaseMappable? {
        let result: Country? = uniqueEntityForMapping(map: map)
        return result
    }
    
    public func mapping(map: Map) {
        self.capitalCity <- map["capitalCity"]
        self.longitude <- map["longitude"]
        self.latitude <- map["latitude"]
        self.nativeName <- map["nativeName"]
        self.populationQty <- map["population"]
        self.regionName <- map["region"]
        self.timezones <- (map["timezones"], StringFromArrayTransform())
        self.currencies <- (map["currencies"], StringFromArrayTransform())
        self.languages <- (map["languages"], StringFromArrayTransform())
    }

    static func uniqueEntityForMapping(map: Map, uniqueKey: String = "countryName") -> Country? {
        if let mapContext = map.context as? CountryMapContext {
            let context = mapContext.context
            let capital = map.JSON["capitalCity"] as? String
            if let identifier = map.JSON["name"] as? String, capital != "" {
                return self.uniqueEntityForId(identifier: identifier, context: context) as? Country
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func uniqueEntityForId(identifier: String,  context: NSManagedObjectContext) -> NSManagedObject {
        var country = self.mr_findFirst(byAttribute: "countryName", withValue: identifier, in: context)
        if country == nil {
            country = self.mr_createEntity(in: context)!
        }
        
        country?.countryName = identifier
        return country!
    }

}
