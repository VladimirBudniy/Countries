//
//  NetworkModel.swift
//  Countries
//
//  Created by Vladimir Budniy on 12/23/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import Foundation

func loadCountries(block: @escaping ([Country]?) -> ()) {
    let url = URL(string: "https://restcountries.eu/rest/v1/all")
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
                Country.parsJSONCountriesDetails(json: json as? [Dictionary<String, Any>], block: block)
            } catch {
                print("Error with Json: \(error)")
            }
        }
    })
    
    task.resume()
}
