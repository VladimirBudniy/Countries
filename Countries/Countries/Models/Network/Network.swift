//
//  Network.swift
//  Countries
//
//  Created by Vladimir Budniy on 2/2/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

import Foundation

typealias objects = ([Country]?) -> ()
typealias error = (Error) -> ()

func loadWith(url: URL, block: @escaping objects, errorBlock: @escaping error) {
    let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData)
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
        do {
            if let data = data, error == nil {
                let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments)
                if let JSON = json as? [Dictionary<String, Any>] {
                    Country.parsJSON(json: JSON, type: .country, block: block, errorBlock: errorBlock)
                } else if let JSON = json as? [Any] {
                    Country.parsJSON(json: JSON.last as? [Dictionary<String, Any>], type: .countries, block: block, errorBlock: errorBlock)
                }
            } else {
                DispatchQueue.main.async {
                    errorBlock(error!)
                }
            }
        } catch {
            DispatchQueue.main.async {
                errorBlock(error)
            }
        }
    })
    
    task.resume()
}
