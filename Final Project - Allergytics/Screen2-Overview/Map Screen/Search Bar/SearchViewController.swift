//
//  SearchViewController.swift
//  Final Project - Allergytics
//
//  Created by user284704 on 11/11/25.
//

import UIKit
import MapKit

class SearchViewController: UIViewController {

    // --- Define and create elements --- //
    var delegateToMapView: MapViewController!             // set delegate of the viewcontroller
    var mapItems = [MKMapItem]()                          // variable to store search results
    let notificationCenter = NotificationCenter.default   // setup notification center
    let searchBottomSheet = SearchView()                  // set the bottom sheet view

    // --- Load View --- //
    override func loadView() {view = searchBottomSheet}
    
    // --- View Did Load --- //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors().offwhite    // Background color for screen
        searchBottomSheet.tableViewSearchResults.delegate = self         // Table delegate setup
        searchBottomSheet.tableViewSearchResults.dataSource = self       // Table datasource setup
        searchBottomSheet.tableViewSearchResults.separatorStyle = .none  // Remove the separator line between cells
        searchBottomSheet.searchBar.delegate = self                      // Search bar delegate setup
        
        notificationCenter.addObserver(                                  // Setup observer to listen for changes in notif center
            self,
            selector: #selector(notificationForPlaces(notification:)),   // notif sent by viewcontroller when notifforplaces finishes a search
            name: .placesFromMap,                                        // This is the notification we will listen to
            object: nil
        )
        
    }
    
    // --- NOTIFICATION FUNCTION --- //
    @objc func notificationForPlaces(notification: Notification){
        mapItems = notification.object as! [MKMapItem]               // Stores the places of the notif and puts them in mapitems
        self.searchBottomSheet.tableViewSearchResults.reloadData()   // relod the table
    }
    
}

// ---------------------------------------------------------------------------------------------------------------------------
extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {  // Call when user types something
        delegateToMapView.loadPlacesAround(query: searchText)                     // search for places with that text
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {  // close search screen if cancel or close is tapped
        self.dismiss(animated: true)
    }
}
// ---------------------------------------------------------------------------------------------------------------------------

// ---- Extension for the table view in the search view controller !! --- //
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return mapItems.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.searchTableViewID, for: indexPath) as! SearchTableViewCell
        if let name = mapItems[indexPath.row].name{
                cell.labelTitle.text = name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegateToMapView.mapView.mapView.annotations.forEach { annotation in // Delete searched place bc its not part of allergy recordss
            if let place = annotation as? Place {             // Make sure searched location resets
                if place.severity == "" && place.title != "You Are Here" { delegateToMapView.mapView.mapView.removeAnnotation(place) } } }
        delegateToMapView.showSelectedPlace(placeItem: mapItems[indexPath.row])
        self.dismiss(animated: true)
    }
}
