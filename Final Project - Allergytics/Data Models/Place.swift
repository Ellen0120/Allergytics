//
//  Place.swift
//  Final Project - Allergytics
//
//  Created by Arive Maynes on 11/11/25.
//

import MapKit
import UIKit

// --- Create our custom Pin PLACE object --- //
class Place: NSObject, MKAnnotation {         // Simple object with protocol for map annotation
    var title: String?                        // Name of the place
    var coordinate: CLLocationCoordinate2D    // Coordinates of the place
    var info: String                          // Store additional info
    var id: String
    var severity: String

    init(title: String, coordinate: CLLocationCoordinate2D, info: String, id: String, severity: String) {  // Initialize with these fields
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.id = id
        self.severity = severity
    }
    
    var mapItem: MKMapItem?{                 // Converts our PLACE object into a MKMapItem so we can open directions
        guard let location = title else{ return nil  }  // If our location pin doesnt have a title, set it to nil, if not use title name
        let placemark = MKPlacemark(         // Create a placemark object that represents a physical location on earth
            coordinate: coordinate,          // we put the coordinates
            addressDictionary:  [:]          // and give no address
        )
        let mapItem = MKMapItem(placemark: placemark)  // create our mkmapitem with the placemark variable
        mapItem.name = title                           // set its title
        return mapItem                                 // and return it
    }
}
