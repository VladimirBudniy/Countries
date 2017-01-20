//
//  Annotation.swift
//  Countries
//
//  Created by Vladimir Budniy on 1/20/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
