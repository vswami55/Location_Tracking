//
//  CustomPin.swift
//  AssignmentApp
//
//  Created by Virender Swami on 06/04/22.
//

import UIKit
import MapKit
import CoreLocation

class CustomPin:NSObject, MKAnnotation  {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    var pinTintColor: UIColor
    
init(id: String, title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, pinTintColor: UIColor) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate
    self.pinTintColor = pinTintColor
    
    super.init()
    }
}
