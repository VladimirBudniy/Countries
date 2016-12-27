//
//  NetworkModel.swift
//  Countries
//
//  Created by Vladimir Budniy on 12/23/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import Foundation

let requestedURL = "http://api.worldbank.org/countries?per_page="
let requestFormat = "&format=json"
let requestPage = "&page="

class NetworkModel {
    
//    static func loadCountries(perPage: String = "30", page: String, block: @escaping (Array<Country>) -> ()) {
//
//        let requestURL = requestedURL + perPage + requestFormat + requestPage + page
//        let url = URL(string: requestURL)
//        let request = URLRequest(url: url!)
//        
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//
//        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
//            if error == nil {
//                do{
//                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
//                    let array = ParsingModel.parsJSONCountries(json: json as! Array<Any>)
//                    
//                    DispatchQueue.main.async {
//                        block(array)
//                    }
//
//                }catch {
//                    print("Error with Json: \(error)")
//                }
//            }
//            
//            let httpResponse = response as! HTTPURLResponse
//            let statusCode = httpResponse.statusCode
//            if statusCode == 200 {
//                print("Data has been loaded successfully")
//            }
//        })
//        
//        task.resume()
//    }
    
    static func loadCountries(block: @escaping (Array<Country>) -> ()) {
        let requestURL = "https://restcountries.eu/rest/v1/all"
        let url = URL(string: requestURL)
        let request = URLRequest.init(url: url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData)
//        let request = URLRequest(url: url!)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error == nil {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    let array = ParsingModel.parsJSONCountries(json: json as! Array<Any>)
                    
                    DispatchQueue.main.async {
                        block(array)
                    }
                    
                }catch {
                    print("Error with Json: \(error)")
                }
            }
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if statusCode == 200 {
                print("Data has been loaded successfully")
            }
        })
        
        task.resume()
    }

}
