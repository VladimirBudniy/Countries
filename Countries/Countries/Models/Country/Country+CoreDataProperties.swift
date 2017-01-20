//
//  Country+CoreDataProperties.swift
//  Countries
//
//  Created by Vladimir Budniy on 12/27/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country");
    }

    @NSManaged public var capitalCity: String?
    @NSManaged public var countrieName: String?
    @NSManaged public var timezones: String?
    @NSManaged public var regionName: String?
    @NSManaged public var populationQty: Int64
    @NSManaged public var nativeName: String?
    @NSManaged public var currencies: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var languages: String?
}
