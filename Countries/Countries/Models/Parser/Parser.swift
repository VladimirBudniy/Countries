//
//  Parser.swift
//  Countries
//
//  Created by Vladimir Budniy on 1/18/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import CoreData

var array = [Country]()
var currentCountry: Country?

typealias objects = ([Country]?) -> ()
typealias object = (Country?) -> ()
typealias error = (Error) -> ()

func parsJSONCountriesDetails(json: [Dictionary<String, Any>]?, block: @escaping object, errorBlock: @escaping error) {
    let database = DatabaseController.sharedInstance
    let mainContext = database.getMainContext()
    let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    privateContext.parent = mainContext
    privateContext.perform ({
        if let countries = json {
            for item in countries {
                let countryName: String? = item~?"name"
                let country = database.findEntity(in: privateContext, predicate: countryName) as? Country
                country?.nativeName = item~?"nativeName"
                country?.populationQty = item~"population"
                country?.regionName = item~?"region"
                country?.timezones = item~?"timezones"
                country?.currencies = item~?"currencies"
                country?.languages = item~?"languages"
                currentCountry = country
            }
        }
        do {
            try privateContext.save()
            mainContext.performAndWait {
                do {
                    try mainContext.save()
                    print("Data has been loaded successfully")
                    let country = database.findEntity(in: mainContext, predicate: currentCountry?.countrieName) as? Country
                    block(country)
                } catch {
                    errorBlock(error)
//                    fatalError("Failure to save mainContext: \(error)")
                }
            }
        } catch {
            DispatchQueue.main.async {
                errorBlock(error)
            }
//            fatalError("Failure to save privateContext: \(error)")
        }
    })
}

func parsJSONCountries(json: [Dictionary<String, Any>]?, block: @escaping objects, errorBlock: @escaping error) {
    let database = DatabaseController.sharedInstance
    let mainContext = database.getMainContext()
    let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    privateContext.parent = mainContext
    privateContext.perform ({
        if let countries = json {
            for item in countries {
                let capital = item["capitalCity"] as! String? // The need according of correctness API
                if capital != "" {
                    let countryName: String? = item~?"name"
                    let country = database.findOrCreateEntity(context: privateContext, predicate: countryName) as? Country
                    country?.countrieName = countryName
                    country?.capitalCity = item~?"capitalCity"
                    country?.longitude = item~?"longitude"
                    country?.latitude = item~?"latitude"
                    array.append(country!)
                }
            }
        }
        do {
            try privateContext.save()
            mainContext.performAndWait {
                do {
                    try mainContext.save()
                    print("Data has been loaded successfully")
                    var objects = [Country]()
                    for item in array {
                        let country = database.findEntity(in: mainContext, predicate: item.countrieName) as? Country
                        objects.append(country!)
                    }
                    block(objects)
                    array.removeAll()
                } catch {
                    errorBlock(error)
//                    fatalError("Failure to save mainContext: \(error)")
                }
            }
        } catch {
            DispatchQueue.main.async {
                errorBlock(error)
            }
//            fatalError("Failure to save privateContext: \(error)")
        }
    })
}
