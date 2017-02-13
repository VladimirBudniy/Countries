//
//  Country+RemoveAll.swift
//  Countries
//
//  Created by Vladimir Budniy on 2/7/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import MagicalRecord
import ReactiveCocoa
import ReactiveSwift

extension Country {
    
    public static func removeAll() -> SignalProducer<Bool, NSError> {
        return SignalProducer {(observer, compositeDisposable) in
            MagicalRecord.save({ context in
                let objects = Country.mr_findAll(in: context)
                context.mr_deleteObjects(objects as! NSFastEnumeration)
            }, completion: { (didSaved, error) in
                if let error = error {
                    observer.send(error: error as NSError)
                } else {
                    observer.send(value: didSaved)
                    observer.sendCompleted()
                }
            })
        }
    }
}
