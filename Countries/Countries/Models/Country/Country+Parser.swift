//
//  Country+Parser.swift
//  Countries
//
//  Created by Vladimir Budniy on 2/2/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import CoreData

enum dataType {
    case countries
    case country
}

typealias parseDataType = dataType

extension Country {
    
    static func parsJSON(json: [Dictionary<String, Any>]?, type:parseDataType, block: @escaping objects, errorBlock: @escaping error) {
        var entities = [Country]()
        let privateContext = NSManagedObjectContext.privateContext()
        privateContext.perform ({
            if let countries = json {
                for item in countries {
                    if item["capitalCity"] as! String?  != "" {
                        let country = NSManagedObjectContext.findOrCreateEntity(in: privateContext, with: item~?"name") as? Country
                        if let newCountry = country, type == dataType.countries {
                            newCountry.capitalCity = item~?"capitalCity"
                            newCountry.longitude = item~?"longitude"
                            newCountry.latitude = item~?"latitude"

                            entities.append(newCountry)
                        } else if let currentCountry = country, type == dataType.country {
                            currentCountry.nativeName = item~?"nativeName"
                            currentCountry.populationQty = item~"population"
                            currentCountry.regionName = item~?"region"
                            currentCountry.timezones = item~?"timezones"
                            currentCountry.currencies = item~?"currencies"
                            currentCountry.languages = item~?"languages"
                            
                            entities.append(currentCountry)
                        }
                    }
                }
            }
            do {
                try privateContext.save()
                print("Data has been loaded successfully")
                var objects = [Country]()
                for item in entities {
                    let country = NSManagedObjectContext.findEntity(in: privateContext.parent!, predicate: item.countryName) as? Country
                    objects.append(country!)
                }
                
                DispatchQueue.main.async {
                    block(objects)
                }
                
            } catch {
                DispatchQueue.main.async {
                    errorBlock(error)
                }
            }
        })
    }

}
