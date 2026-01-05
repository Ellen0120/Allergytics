//
//  MapViewController.swift
//  Final Project - Allergytics
//
//  Created by Arive Maynes on 11/11/25.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseFirestore

class MapViewController: UIViewController {
    
    // --- Declare varibles --- //
    let mapView = MapView()                                     // connect with my view for the first screen
    let locationManager = CLLocationManager()                   // Set the location manager so ios can ask me for location
    var currentLocation: CLLocation?                            // To store current location
    var currentUser:FirebaseAuth.User?                          // Create a variable to keep an instance of the current signed-in Firebase user
    var handleAuth: AuthStateDidChangeListenerHandle?           // Create authentication state change listener to track user is signed in
    let database = Firestore.firestore()                        // Create an instance of the Firebase database
    var pinslist = [PinLocation]()                              // To store my pins recovered from firebase
    var mappins = [Place]()                                     // To create the MapKit Annotations with info recovered from firebase
    var pinslocations: [Any] = []                               // Svae information recovered directly from firebase
    let legendView = LegendView()                               // connect legend view file to display it with the button
    var legendHeightConstraint: NSLayoutConstraint!             // Variable to setup and change height of Legend View
    let overlayView = UIView()                                  // Create overlay for when we have legend view and dismiss it when tap outside
    let notificationCenter = NotificationCenter.default         // Create notification center
    var hasCenteredOnce = false                                 // The current location when first log in
    var searchpin: MKAnnotation?                                // Save info for the search screen pin selected
    
    // --- Load View --- //
    override func loadView() { view = mapView }
    
    // --- View Will Appear --- //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pinslocations.removeAll()                                        // Reset the array
    }
    
    // --- View Did Load --- //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors().offwhite    // Background color for screen
        navigationController?.navigationBar.prefersLargeTitles = true       // nav bar titles
        setupLocationManager()                                              // Setting up location manager
        //onButtonCurrentLocationTapped()                                     // Center the map view to current location when the app loads
        loadlegendviewdetails()                                             // Load the initial setup for the legend display
        setupoverlay()                                                      // Losd overlay for legend display and gesture recognizer
        mapView.mapView.delegate = self                                     // Setting the delegate for the Map View
        // Button Actions: Current Location, Search & Legend //
        mapView.buttonCurrentLocation.addTarget(self, action: #selector(onButtonCurrentLocationTapped), for: .touchUpInside)
        mapView.buttonSearch.addTarget(self, action: #selector(onButtonSearchTapped), for: .touchUpInside)
        mapView.buttonLegend.addTarget(self, action: #selector(onButtonLegendTapped), for: .touchUpInside)
        // Update pin locations when view did load & when records get updated
        notificationCenter.addObserver(self, selector: #selector(fetchPinLocations), name: .recordReloaded, object: nil)
        fetchPinLocations()
        // Gesture recognizer to the map screen
        let tap = UITapGestureRecognizer(target: self, action: #selector(mapTapped(_:)))
        tap.cancelsTouchesInView = false
        mapView.addGestureRecognizer(tap)
    }
    
    // --- View Will Dissapear --- //
    override func viewWillDisappear(_ animated: Bool) {      // Lifecycle to handle the logic right before the screen disappears
        super.viewWillDisappear(animated)
    }
    
    // ------------------------------------------------- FUNCTIONS ------------------------------------------------------ //
    
    // --- FETCH HISTORY DATA --- //
    @objc func fetchPinLocations() {
        let historyList = HistoryStore.shared.history
        self.pinslocations.removeAll()
        for record in historyList {
            var locationDict: [String: Any]
            if let location = record.location {
                locationDict = [
                    "name": location.name,
                    "address": location.address,
                    "latitude": location.latitude,
                    "longitude": location.longitude
                ] as [String: Any]
            } else {
                continue
            }
            locationDict["id"] = record.id                       // include ID of the document for taking to details screen
            locationDict["severity"] = record.severity           // include sevetiry for color coding purposes
            self.pinslocations.append(locationDict)              // save that information
        }
        self.getpinsonmap(pins: self.pinslocations)              // send fetched data to getpinsonmap func
    }
    
    // --- CREATE MAP PINS TO DISPLAY --- //
    func getpinsonmap(pins:[Any]){
        self.pinslist.removeAll()                                        // Reset the arrays
        self.mappins.removeAll()                                         // Reset the arrays
        mapView.mapView.removeAnnotations(mapView.mapView.annotations)   // Rest map annotations so they dont duplicate
        for item in pins {                                               // For each item in my array
            if let dict = item as? [String: Any] {                       // Create a dictionary each time I run this
                guard let address = dict["address"] as? String, let name = dict["name"] as? String,  // I will save each field of each item
                      let latitude = dict["latitude"] as? Double, let longitude = dict["longitude"] as? Double,
                      let id = dict["id"] as? String, let severity = dict["severity"] as? String
                else { print("Skipping invalid item:", dict); continue }   //
                // convert to PinLocation //
                let pin = PinLocation(id: id, address: address,latitude: latitude,longitude: longitude,name: name, severity: severity)
                self.pinslist.append(pin)                                  // Add that pin to my array
            } }
        // Analyze if I have duplicated pins based on lat + long //
        let grouped = Dictionary(grouping: self.pinslist) { pin in "\(pin.latitude)_\(pin.longitude)" } // Group those w/ == address
        for (_, group) in grouped {         // now for each pin we need to convert it to a Place type to display a annotation
            let total = group.count         // count how many pins we have in the dictionary
            for (index, pin) in group.enumerated() {  // for each group
                let baseCoord = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude) // call ofset function to replace coord
                let offsetCoord = offsetCoordinate(base: baseCoord, index: index, total: total) // replace OG coords with offset ones (if need)
                let place = Place( title: pin.name, coordinate: offsetCoord, info: pin.address,
                                   id: pin.id, severity: pin.severity) // create my place objects
                self.mappins.append(place)   // add that place to my array
        } }
        mapView.mapView.addAnnotations(self.mappins)   // Create Pin Annotations Objects
        youareherepin()                                // Make sure user location pin shows up when its simulated
    }
    
    // --- CREATE AN OFFSET for pins in the same location!! --- //
    func offsetCoordinate(base: CLLocationCoordinate2D, index: Int, total: Int) -> CLLocationCoordinate2D {
        if total <= 1 { return base }  // if i have only one pin in a location, then we just display it as usual
        let angle = (Double(index) / Double(total)) * (2 * Double.pi)  // calculate the angle for the offset for repeated pins
        let radius = 0.00015                                          // radius in meters we can change this (low = pins closer)
        // modify the lat, long of those pins that share location, so we can see them all in the map in a circle
        return CLLocationCoordinate2D( latitude: base.latitude + radius * cos(angle), longitude: base.longitude + radius * sin(angle))
    }
    
    // --- YOU ARE HERE SIMULATED PIN --- //
    func youareherepin(){                                                                     // This will run when we load record pins
        #if targetEnvironment(simulator)                                                      // If simulation then set pin annotation
        let simCoord = SimulatedCoord().simulation                                            // Set simulated coordinates
            mapView.mapView.showsUserLocation = false                                         // disable system blue dot
            mapView.mapView.annotations.forEach { annotation in                               // Remove old simulated annotation
                if annotation.title == "You Are Here" { mapView.mapView.removeAnnotation(annotation) }  }
            let simlocation = Place( title: "You Are Here", coordinate: simCoord, info: "", id: "", severity:"" ) // Place struct for SIMULATOR
            mapView.mapView.addAnnotation(simlocation)                                        // Add a pin for users sim location
        #else                                                                                 // If real device, make sure we delete the sim pin
            mapView.mapView.annotations.forEach { annotation in   // Make sure simulated location doesnt appear (just to be safe)
                if annotation.title == "You Are Here" { mapView.mapView.removeAnnotation(annotation) }  }
        #endif
    }
    
    // --- CURRENT LOCATION BUTTON --- //
    @objc func onButtonCurrentLocationTapped(){     // when current location is tapped, then center the map on that location
        // Check where we are running the app: Simulator or Real Device //
        #if targetEnvironment(simulator)
            youareherepin()
            cleansearchinfo()
        mapView.mapView.centerToLocation(
            location: CLLocation(
                latitude: SimulatedCoord().simulation.latitude,
                longitude: SimulatedCoord().simulation.longitude
            )
            , zoomMeters: 1000) // center here
        #else
            guard let location = self.currentLocation else { return }  // if real device then use gps as normal for that
            mapView.mapView.showsUserLocation = true              // show the user location default blue icon
            mapView.mapView.centerToLocation(location: location, zoomMeters: 1000)  // center to that real location
            mapView.mapView.annotations.forEach { annotation in   // Make sure simulated location doesnt appear
                if annotation.title == "You Are Here" { mapView.mapView.removeAnnotation(annotation) }  }
        #endif
    }
    
    // --- SEARCH BUTTON --- //
    @objc func onButtonSearchTapped(){
        let searchViewController  = SearchViewController()      // Setting up bottom search sheet connect it to its VC
        searchViewController.delegateToMapView = self           // set delegate variable
        let navForSearch = UINavigationController(rootViewController: searchViewController)
        navForSearch.modalPresentationStyle = .pageSheet        // Present it as a bottom sheet
        if let searchBottomSheet = navForSearch.sheetPresentationController{  // set it up
            searchBottomSheet.detents = [.medium(), .large()]; searchBottomSheet.prefersGrabberVisible = true }
        present(navForSearch, animated: true)                  // Show it
    }
    
    // --- CLEAN SEARCH PINS --- //
    func cleansearchinfo() {
        mapView.mapView.annotations.forEach { annotation in   // Delete searched place bc its not part of official allergy recordss
            if let place = annotation as? Place {             // Make sure searched location resets
                if place.severity == "" && place.title != "You Are Here" { mapView.mapView.removeAnnotation(place) } } }
    }
    
    // --- LEGEND BUTTON--- //
    @objc func onButtonLegendTapped(){
        let isCollapsed = legendHeightConstraint.constant == 0
        legendHeightConstraint.constant = isCollapsed ? 100 : 0  // heighet of the legend view screen
        overlayView.isHidden = !isCollapsed  // show overlay only when its expandedd
        UIView.animate(withDuration: 0.3) { self.view.layoutIfNeeded() }
        
    }
    
    // --- LEGEND DROP DOWN MENU SETUP --- //
    func loadlegendviewdetails(){
        legendView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(legendView)                      // add our legend view to the current view of the map screen
        legendHeightConstraint = legendView.heightAnchor.constraint(equalToConstant: 0) // starts collapsed and then we set the constraints
        NSLayoutConstraint.activate([ legendView.topAnchor.constraint(equalTo: mapView.mapView.topAnchor, constant: 50),
            legendView.leadingAnchor.constraint(equalTo: mapView.mapView.leadingAnchor, constant: 10),
            legendView.widthAnchor.constraint(equalToConstant: 150), legendHeightConstraint ]) // heigh changes depending on active or not
    }

    // --- OVERLAY SETUP --- //
    func setupoverlay(){
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.1)   // dim the rest of the screen a bitt
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.isHidden = true                                           // start its setting with overlay hiddenn
        view.insertSubview(overlayView, belowSubview: legendView)             // add this view below the legend view
        NSLayoutConstraint.activate([                                         // set the constraints the same as the screen
            overlayView.topAnchor.constraint(equalTo: view.topAnchor), overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor), ])
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOutsideLegend)) // create gesture recognizer and func!
        overlayView.addGestureRecognizer(tapGesture)                         // add the gesture recognizer to our overlay - click to hide legend
    }
    
    // --- TAP RECOGNIZER TO HIDE UIVIEW --- //
    @objc func didTapOutsideLegend() {
        legendHeightConstraint.constant = 0  // collap our legend view by setting height to zeroo
        overlayView.isHidden = true          // Hide our overlay bc we dont need it if legend view is collapsed
        UIView.animate(withDuration: 0.3) { self.view.layoutIfNeeded() } // animate it
    }
    
    // --- SHOW SELECTED PLACE ON MAP --- //
    func showSelectedPlace(placeItem: MKMapItem){        // we are going to show the place the user selected
        let coordinate = placeItem.placemark.coordinate  // get coordinates of the place selected
        mapView.mapView.centerToLocation(
            location: CLLocation(
                latitude: coordinate.latitude,
                longitude: coordinate.longitude
            ),
            zoomMeters: 900
        )// then center view
        let place = Place(                               // create a PLACE object with the location the user selected
            title: placeItem.name!, coordinate: coordinate, info: placeItem.description,
            id: "", severity: "" )                       // id and severity empty bc this pin isn't part of user's records
        searchpin = place
        mapView.mapView.addAnnotation(place)             // put a pin on the place selected
        mapView.mapView.selectAnnotation(place, animated: true)             // put a pin on the place selected
    }
    
    // --- MAP GESTURE RECOGNIZER FUNCTION --- //
    @objc func mapTapped(_ sender: UITapGestureRecognizer) {    // This detects when the user taps the map
        if let searchpin = searchpin {                          // We deselect and delete the search pin
            mapView.mapView.removeAnnotation(searchpin)         // This way we ensure search is momentary and shows again allergy pins
            self.searchpin = nil                                 // reset the variable
        }
    }
    
}
// ---------------------------------------------------------------------------------------------------------------- //
extension MKMapView{    // this moves the map so the selected loc is in the middle
    func centerToLocation(location: CLLocation, zoomMeters: CLLocationDistance) {
           let region = MKCoordinateRegion(
            center: location.coordinate,
               latitudinalMeters: zoomMeters,
               longitudinalMeters: zoomMeters
           )
           setRegion(region, animated: true)
       }
}
