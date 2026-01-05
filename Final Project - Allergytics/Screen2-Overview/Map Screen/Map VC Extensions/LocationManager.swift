//
//  LocationManager.swift
//  Final Project - Allergytics
//
//  Created by Arive Maynes on 11/11/25.
//

import Foundation
import CoreLocation
import MapKit

// --- Setting up location manager delegate --- //
extension MapViewController: CLLocationManagerDelegate{
    
    // Setting up location manager to get the current location //
    func setupLocationManager(){
        locationManager.delegate = self                            // Delegate tied to View Controller
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  // Get the best accuracy for that location
        locationManager.requestWhenInUseAuthorization()            // Ask permission to use their location
        locationManager.startUpdatingLocation()                    // Start getting the user's location
    }
    
    // Handle "Allow" and "Not Allow" from the pop up message //
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse         // If the user either allows location while using the app
            || manager.authorizationStatus == .authorizedAlways{       // Or selects Always
            manager.requestLocation()    }                             // then we get their location
    }
    
    // Run when we get a location //
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Check where we are running the app: Simulator or Real Device //
        #if targetEnvironment(simulator)
            let simCoord = SimulatedCoord().simulation                                         // Set simulated coordinates
            mapView.mapView.showsUserLocation = false                                         // disable system blue dot
            mapView.mapView.annotations.forEach { annotation in                               // Remove old simulated annotation
                if annotation.title == "You Are Here" {
                    mapView.mapView.removeAnnotation(annotation)
                }
            }
        
        // Add simulated pin
            let simlocation = Place(
                title: "You Are Here",
                coordinate: simCoord,
                info: "",
                id: "",
                severity:""
            ) // Place struct for SIMULATOR
            mapView.mapView.addAnnotation(simlocation)                                        // Add a pin for users sim location
        
            if !hasCenteredOnce {
                mapView.mapView.centerToLocation(
                        location: CLLocation(latitude: simCoord.latitude, longitude: simCoord.longitude),
                        zoomMeters: 800
                    )  // center to that real location
                hasCenteredOnce = true
            }
           
        #else
            guard let location = locations.first else { return }  // if real device then use gps as normal for that
            self.currentLocation = location
            mapView.mapView.showsUserLocation = true              // show the user location default blue icon
        
            if !hasCenteredOnce {
                mapView.mapView.centerToLocation(
                    location: location,
                    zoomMeters: 800
                )  // center to that real location
                hasCenteredOnce = true
            }
            
        #endif
        mapView.buttonLoading.isHidden = true                     // Then we hide the button that shows loading message
        mapView.buttonSearch.isHidden = false                     // And show the search bar at the bottom
    }
    
    // If something failed, this runs and displays message //
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { print("location error: \(error.localizedDescription)") }
    
}
