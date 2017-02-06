//
//  Network.swift
//  Countries
//
//  Created by Vladimir Budniy on 2/2/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import Alamofire

typealias objects = ([Country]?) -> ()
typealias error = (Error) -> ()

func loadWith(url: URL, block: @escaping objects, errorBlock: @escaping error) {
    Alamofire.request(url).responseJSON { respons in
        if let JSON = respons.result.value as? [Dictionary<String, Any>], respons.result.isSuccess {
            Country.parsJSON(json: JSON, type: .country, block: block, errorBlock: errorBlock)
        } else if let JSON = respons.result.value as? [Any], respons.result.isSuccess {
            Country.parsJSON(json: JSON.last as? [Dictionary<String, Any>], type: .countries, block: block, errorBlock: errorBlock)
        }
    }
}
