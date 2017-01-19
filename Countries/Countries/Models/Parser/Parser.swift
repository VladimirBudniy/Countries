//
//  NetworkModel.swift
//  Countries
//
//  Created by Vladimir Budniy on 1/18/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import CoreData

var array: [Country]?

public func parsJSONCountriesDetails(json: [Dictionary<String, Any>]?, block: @escaping ([Country]?) -> ()) {
    let database = DatabaseController.sharedInstance
    let mainContext = database.getMainContext()
    let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    privateContext.parent = mainContext
    privateContext.perform ({
        if let countries = json {
            for item in countries {
                let country = database.createCountryIn(context: privateContext) as? Country // fetch entity
                
                //                    country?.countrieName = item~"name"
                //                    country?.capitalCity = item~"capital"
                country?.nativeName = item~"nativeName"
                country?.populationQty = (item~"population")!
                country?.regionName = item~"region"
                country?.timezones = item~"timezones"
                country?.currencies = item~"currencies"
            }
        }
        do {
            try privateContext.save()
            mainContext.performAndWait {
                do {
                    try mainContext.save()
                    print("Data has been loaded successfully")
                    block(database.fetchEntities())
                } catch {
                    fatalError("Failure to save mainContext: \(error)")
                }
            }
        } catch {
            fatalError("Failure to save privateContext: \(error)")
        }
    })
}

public func parsJSONCountries(json: [Dictionary<String, Any>]?, block: @escaping ([Country]?) -> ()) {
    let database = DatabaseController.sharedInstance
    let mainContext = database.getMainContext()
    let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    privateContext.parent = mainContext
    privateContext.perform ({
        if let countries = json {
            for item in countries {
                
                let capital = item["capitalCity"] as! String?
                if capital != "" {
                    let country = database.createCountryIn(context: privateContext) as? Country
                    country?.countrieName = item~"name"
                    country?.capitalCity = item~"capitalCity"
                }
            }
        }
        do {
            try privateContext.save()
            mainContext.performAndWait {
                do {
                    try mainContext.save()
                    print("Data has been loaded successfully")
                    block(database.fetchEntities())
                } catch {
                    fatalError("Failure to save mainContext: \(error)")
                }
            }
        } catch {
            fatalError("Failure to save privateContext: \(error)")
        }
    })
}
