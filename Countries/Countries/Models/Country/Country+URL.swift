//
//  Country+URL.swift
//  Countries
//
//  Created by Vladimir Budniy on 2/3/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

let requestedURL = "http://api.worldbank.org/countries?per_page=30&format=json&page="
let countryDetailsURL = "https://restcountries.eu/rest/v1/name/"

extension Country {
    
    static func url(for page: Int) -> URL? {
        return URL(string: requestedURL + String(page))
    }
    
    static func urlFor(country name: String) -> URL? {
        return URL(string: countryDetailsURL + name.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
    }
}
