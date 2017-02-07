//
//  Network.swift
//  Countries
//
//  Created by Vladimir Budniy on 2/2/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveCocoa
import ReactiveSwift

func loadWith(url: URL) -> SignalProducer<[Country], NSError> {
    return SignalProducer { (observer, compositeDisposable) in
        Alamofire.request(url).responseJSON { respons in
            if let JSON = respons.result.value as? [Dictionary<String, Any>], respons.result.isSuccess {
                Country.parsJSON(json: JSON)
                    .observe(on: UIScheduler())
                    .startWithResult({ result in
                    switch result {
                    case .success:
                        observer.send(value: result.value!)
                        observer.sendCompleted()
                    case let .failure(error):
                        observer.send(error: error)
                    }
                })
            } else if let JSON = respons.result.value as? [Any], respons.result.isSuccess {
                Country.parsJSON(json: JSON.last as? [Dictionary<String, Any>])
                    .observe(on: UIScheduler())
                    .startWithResult({ result in
                    switch result {
                    case .success:
                        observer.send(value: result.value!)
                        observer.sendCompleted()
                    case let .failure(error):
                        observer.send(error: error)
                    }
                })
            }
        }
    }
}

