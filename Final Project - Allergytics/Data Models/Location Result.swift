//
//  Location Result.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/15.
//

import Foundation
import CoreLocation

struct LocationResult: Codable {
    let name: String
    let address: String
    let latitude: Double 
    let longitude: Double
    
    // Custom initializer from CLLocationCoordinate2D
    init(name: String, address: String, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.address = address
        self.latitude = coordinates.latitude
        self.longitude = coordinates.longitude
    }
       
    // Helper to convert back to CLLocationCoordinate2D if needed
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
