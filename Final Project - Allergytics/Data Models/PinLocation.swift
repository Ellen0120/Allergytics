//
//  PinLocation.swift
//  Final Project - Allergytics
//
//  Created by Arive Maynes on 11/20/25.
//

import Foundation
import FirebaseFirestoreSwift

struct PinLocation: Codable{
    var id: String
    var address: String
    var latitude: Double
    var longitude: Double
    var name: String
    var severity: String
    
    init( id: String, address: String, latitude: Double, longitude: Double, name: String, severity: String) {
        self.id = id
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.severity = severity
    }
}
