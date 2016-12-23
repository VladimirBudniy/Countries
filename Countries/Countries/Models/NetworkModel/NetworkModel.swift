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
    
    static func load(perPage: String = "15", page: String = "1") {

        let requestURL = requestedURL + perPage + requestFormat + requestPage + page
        let url = URL(string: requestURL)
        let request = URLRequest(url: url!)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error == nil {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    let objects = ParsingModel.parsJSONToArray(json: json as! Array)
                    print(objects as Any)
                }catch {
                    print("Error with Json: \(error)")
                }
            }
        })
        
        task.resume()
    }

}


//            let httpResponse = response as! HTTPURLResponse
//            let statusCode = httpResponse.statusCode

//            if response != nil {
//                print("Error: did not receive data")
//            }
//
//            if error != nil {
//                print("error calling GET on /todos/1")
//                print(error as Any)
//            }
