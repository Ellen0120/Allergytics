//
//  NearPlaces.swift
//  Final Project - Allergytics
//
//  Created by Arive Maynes on 11/11/25.
//

import Foundation
import CoreLocation
import MapKit

// This extension will listen to places nearby and show them //
extension MapViewController{
    func loadPlacesAround(query: String){
        // --- Define variables --- //
        let notificationCenter = NotificationCenter.default  // Set up the notification center
        var mapItems = [MKMapItem]()                         // List to hold the search results values
        
        // --- Create search request --- //
        let searchRequest = MKLocalSearch.Request()        // so we can search for whatever the user typed
        searchRequest.naturalLanguageQuery = query         // search for whatver the user wrote
        searchRequest.region = mapView.mapView.region      // Set the region to an associated map view's region - search nearby and limit search

        // --- Start the search --- //
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in                // the response is the list of results, and error if I got an error
            guard let response = response else { return }  // Hanlde the error in here - if something went wrong, we stop
            mapItems = response.mapItems                   // Save results in my variable
            
            // this just prints results in terminal in xcode //
          //  for item in response.mapItems { if let name = item.name,let location = item.placemark.location { print("\(name), \(location)") }}
            
            // posting the search results in notification center //
            notificationCenter.post(name: .placesFromMap, object: mapItems)
        }
    }
}
