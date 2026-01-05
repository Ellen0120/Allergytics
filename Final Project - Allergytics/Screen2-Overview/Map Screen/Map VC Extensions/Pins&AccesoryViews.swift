//
//  Pins&AccesoryViews.swift
//  Final Project - Allergytics
//
//  Created by Arive Maynes on 11/11/25.
//

import Foundation
import MapKit
import FirebaseAuth
import FirebaseFirestore

extension MapViewController: MKMapViewDelegate{
    
    // --- Customize how annotation pins look --- //
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let cluster = annotation as? MKClusterAnnotation {
            let clusterView = MKMarkerAnnotationView(annotation: cluster, reuseIdentifier: "cluster")
            clusterView.markerTintColor = Colors().olive
            clusterView.canShowCallout = true
            return clusterView
        }
        guard let annotation = annotation as? Place else { return nil }   // Check that the annotation has PLACE struct
        var view: MKMarkerAnnotationView                                              // If not then we create one
        view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Configs.placeIdentifier)
        view.canShowCallout = true                                    // Enable the call out element
        view.calloutOffset = CGPoint(x: -5, y: 5)                     // Set the call out bubble position
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) // Add title "details" button on right side
        view.clusteringIdentifier = "placeCluster"                    // Enable clusters for pins in same location!

        // Color-Code pins based on severity
        switch annotation.severity {                           // get info of severity for each annotation I have
        case "Low": view.markerTintColor = .systemGreen        // if its low, then color green
        case "Medium": view.markerTintColor = .systemOrange    // if its medium then color orange
        case "High": view.markerTintColor = .systemRed         // if its high then color red
        default: view.markerTintColor = .systemGray            // if its none (like when using the search bar) its gray
        }
        
        // Color-code for user's location pin + disable accessory buttons for user sim lcation
        if annotation.title == "You Are Here" {
            view.markerTintColor = .systemBlue
            view.glyphImage = UIImage(systemName: "person.fill")
            view.titleVisibility = .hidden
            view.canShowCallout = false
            view.rightCalloutAccessoryView = nil
            view.leftCalloutAccessoryView = nil
            view.detailCalloutAccessoryView = nil
        }
        
        // Disable accessory button for locations the user searches for but are not part of their records
        if annotation.severity == "" &&  annotation.title != "You Are Here" {
            view.glyphImage = UIImage(systemName: "mappin.circle.fill")
            view.clusteringIdentifier = nil
            view.titleVisibility = .hidden
            view.canShowCallout = false
            view.rightCalloutAccessoryView = nil
            view.leftCalloutAccessoryView = nil
            view.detailCalloutAccessoryView = nil
        }
        
        return view
    }
    
    // --- This will handle when we click on the "i" icon --- //
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? Place else { return }                 // Check that the annotation has PLACE struct
        if annotation.title == "You Are Here" { return }                                 // Block i click on user's simulated location
        let selectedrecord = annotation.id                                               // Save this recor's document ID
        self.handleAuth = Auth.auth().addStateDidChangeListener { auth, user in          // Firebase call to get info of that record
            guard let user = user else { return }
            self.database.collection("User").document(user.uid)
                .collection("AllergyRecords").document(selectedrecord).getDocument { snapshot, error in
                    if let error = error { print("Error fetching document: \(error)"); return }
                    guard let snapshot = snapshot, snapshot.exists else { print("Document does not exist"); return }
                    do {
                        let record = try snapshot.data(as: AllergyRecord.self)           // Save result as Allergy Record Type
                        let viewAllergyController = Screen3_VC()                     // Go to the details screen and display info of that record
                        viewAllergyController.statusViewing = true
                        viewAllergyController.receivedRecord = record
                        self.navigationController?.pushViewController(viewAllergyController, animated: true) // Open Details View Screen
                    } catch { print("Error decoding document:", error) }
                }
        }
    }
    
    // --- This will handle when we tap on a pin cluster --- //
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let cluster = view.annotation as? MKClusterAnnotation else { return }
        let annotations = cluster.memberAnnotations         // Get coordinates of all member annotations
        var zoomRect = MKMapRect.null                       // Create a MKMapRect with all annotations from clusters
        for annotation in annotations {                     // Then for each of them set the zoom
            let point = MKMapPoint(annotation.coordinate)   // points corresponds to coordinates of each individual pin
            let rect = MKMapRect(x: point.x, y: point.y, width: 0, height: 0)  // then the zoom rectangle has these dimensions
            zoomRect = zoomRect.union(rect)                 // we zoom depending on the rectangles dimensions
        }

        let edgePadding = UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100)  // Add padding for zoom rect (20% of the dimensions)
        mapView.setVisibleMapRect(zoomRect, edgePadding: edgePadding, animated: true) // zoom with dim and padding so its not intense zoom in

        // Deselect cluster so it can be tapped again
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { mapView.deselectAnnotation(view.annotation, animated: false) }
    }
    
}
