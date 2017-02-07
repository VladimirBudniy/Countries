//
//  Country+MapContext.swift
//  Countries
//
//  Created by Vladimir Budniy on 2/7/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import CoreData
import ObjectMapper

struct CountryMapContext: MapContext {
    
    let context : NSManagedObjectContext
    let mapContextInfo: AnyObject?
    
    init(context: NSManagedObjectContext, mapContextInfo: AnyObject? = nil) {
        self.context = context
        self.mapContextInfo = mapContextInfo
    }
}
