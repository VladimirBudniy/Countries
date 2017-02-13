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
import ReactiveCocoa
import ReactiveSwift

enum dataType {
    case countries
    case country
}

typealias parseDataType = dataType

extension Country {
    
    static func parsJSON(json: [Dictionary<String, Any>]?) -> SignalProducer<[Country], NSError> {
        return SignalProducer { (observer, compositeDisposable) in
            var result: [Country]?
            MagicalRecord.save({ context in
                if let array = json {
                    let mapContext = CountryMapContext(context: context)
                    result = Mapper<Country>(context: mapContext).mapArray(JSONArray: array)
                }
            }, completion: { success, error in
                if let error = error {
                    observer.send(error: error as NSError)
                } else {
                    var objects = [Country]()
                    for item in result! {
                        if let country = item.mr_(in: NSManagedObjectContext.mr_default()) {
                            objects.append(country)
                        }
                    }
                    
                    observer.send(value: objects)
                    observer.sendCompleted()
                }
            })
        }
    }
    
}
