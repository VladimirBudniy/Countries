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

let countryDetailsURL = "https://restcountries.eu/rest/v1/name/"

extension Country {
    
    typealias objects = ([Country]?) -> ()
    typealias object = (Country?) -> ()
    typealias error = (Error) -> ()

    static func loadCountry(name: String, block: @escaping object, errorBlock: @escaping error) {
        let url = URL(string: countryDetailsURL + name.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        
        let request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    errorBlock(error!)
                }
            }
            if error == nil {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    parsJSONCountriesDetails(json: json as? [Dictionary<String, Any>], block: block, errorBlock: errorBlock)
                } catch {
                    DispatchQueue.main.async {
                        errorBlock(error)
                    }
                }
            }
        })
        
        task.resume()
    }
    
    static func load(perPage: String = "30", page: String, block: @escaping objects, errorBlock: @escaping error) {
        let url = URL(string: requestedURL + perPage + requestFormat + requestPage + page)
        
        let request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    errorBlock(error!)
                }
            }
            if error == nil {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? [Any]
                    let JSON = json?.last as? [Dictionary<String, Any>]
                    parsJSONCountries(json: JSON, block: block, errorBlock: errorBlock)
                } catch {
                    DispatchQueue.main.async {
                        errorBlock(error)
                    }
                }
            }
        })
        
        task.resume()
    }
    
    static func loadWith(url: URL, page: String, block: @escaping objects, errorBlock: @escaping error) {
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    errorBlock(error!)
                }
            }
            if error == nil {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    if let JSON = json as? [Dictionary<String, Any>] {
                        parsJSONCountries(json: JSON, block: block, errorBlock: errorBlock)
                    } else if let JSON = json as? [Any] {
                        parsJSONCountries(json: JSON.last as! [Dictionary<String, Any>]?, block: block, errorBlock: errorBlock)
                    }
                } catch {
                    DispatchQueue.main.async {
                        errorBlock(error)
                    }
                }
            }
        })
        
        task.resume()
    }
}
