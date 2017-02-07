//
//  Network.swift
//  Countries
//
//  Created by Vladimir Budniy on 2/2/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import Alamofire

func loadWith(url: URL) {
    Alamofire.request(url).responseJSON { respons in
        if let JSON = respons.result.value as? [Dictionary<String, Any>], respons.result.isSuccess {
            Country.parsJSON(json: JSON)
        } else if let JSON = respons.result.value as? [Any], respons.result.isSuccess {
            Country.parsJSON(json: JSON.last as? [Dictionary<String, Any>])
        }
    }
}


//
//func parsJson(array: Array<AnyObject>) -> SignalProducer<[CountrieModel], NSError> {
//    return SignalProducer { (observer, compositeDisposable) in
//        for element in array {
//            if element.isKindOfClass(NSArray) {
//                let result = Mapper<CountrieModel>().mapArray(element)! as Array<CountrieModel>
//                observer.sendNext(result)
//                observer.sendCompleted()
//            }
//        }
//    }
//}


