//
//  Country+Parsing.swift
//  Countries
//
//  Created by Vladimir Budniy on 1/6/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import CoreData

extension Country {
    
   static func parsJSONCountriesDetails(json: [Dictionary<String, Any>]?, block: @escaping ([Country]?) -> ()) {
        let database = DatabaseController.sharedInstance
        let mainContext = database.getContext()
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = mainContext
        privateContext.perform ({
            if let arrayCountries = json {
                for dictioanry in arrayCountries {
                    let country = database.createEntityIn(context: privateContext, name: String(describing: Country.self)) as? Country

                    country?.countrieName = dictioanry~~"name"
                    country?.capitalCity = dictioanry~~"capital"
                    country?.nativeName = dictioanry~~"nativeName"
                    country?.populationQty = (dictioanry~~"population")!
                    country?.regionName = dictioanry~~"region"
                    country?.timezones = dictioanry~~"timezones"
                    country?.currencies = dictioanry~~"currencies"
                }
            }
            do {
                try privateContext.save()
                
                mainContext.performAndWait {
                    do {
                        try mainContext.save()
                        print("Data has been loaded successfully")
                        block(database.fetchEntity(type: Country.self))
                    } catch {
                        fatalError("Failure to save mainContext: \(error)")
                    }
                }
            } catch {
                fatalError("Failure to save privateContext: \(error)")
            }
        })
    }
}





