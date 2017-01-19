//
//  Country+Network.swift
//  Countries
//
//  Created by Vladimir Budniy on 1/17/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

let requestedURL = "http://api.worldbank.org/countries?per_page="
let requestFormat = "&format=json"
let requestPage = "&page="

let countryURL = "https://restcountries.eu/rest/v1/name/"

extension Country {

    static func loadCountry(name: String, block: @escaping ([Country]?) -> ()) {
        let url = URL(string: countryURL + name)
        let request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            }
            
            if error == nil {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    parsJSONCountriesDetails(json: json as? [Dictionary<String, Any>], block: block)
                } catch {
                    print("Error with Json: \(error)")
                }
            }
        })
        
        task.resume()
    }
    
    static func load(perPage: String = "30", page: String, block: @escaping ([Country]?) -> ()) {
        
        let requestURL = requestedURL + perPage + requestFormat + requestPage + page
        let url = URL(string: requestURL)
        let request = URLRequest(url: url!)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            }
            
            if error == nil {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? [Any]
                    let JSON = json?.last as? [Dictionary<String, Any>]
                    parsJSONCountries(json: JSON, block: block)
                } catch {
                    print("Error with Json: \(error)")
                }
            }
        })
        
        task.resume()
    }
}
