//
//  Screen3_VC+LocationSearch.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/12/3.
//

import Foundation
import UIKit
import CoreLocation


extension Screen3_VC {
    
    // MARK: - Setup Location Search VC
    func setupLocationSearchVC() {
        addChild(locationSearchVC)
        screen3UI.scrollView.addSubview(locationSearchVC.view)
        locationSearchVC.view.translatesAutoresizingMaskIntoConstraints = false
        locationSearchVC.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            locationSearchVC.view.topAnchor.constraint(equalTo: screen3UI.textfieldLocation.bottomAnchor, constant: 8),
            locationSearchVC.view.leadingAnchor.constraint(equalTo: screen3UI.textfieldLocation.leadingAnchor),
            locationSearchVC.view.trailingAnchor.constraint(equalTo: screen3UI.textfieldLocation.trailingAnchor),
            locationSearchVC.view.heightAnchor.constraint(greaterThanOrEqualToConstant: 80)
        
        ])
    }
    
    // MARK: - Text Input (Typing)
    @objc func onTextFieldLocationChanged(_ textField: UITextField) {
        // As long as the user edits text manually → invalidate selection
            didModifyLocation = true
            locationSelected = false

        guard let query = textField.text, !query.isEmpty else {
            locationSearchVC.results.removeAll()
            locationSearchVC.locationSearchUI.tableViewSearchResults.reloadData()
            locationSearchVC.view.isHidden = true
            return
        }
        // User is typing → show dropdown
        locationSearchVC.view.isHidden = false
        SearchManager.shared.searchLocation(for: query)
    }
    
    
    // MARK: - Hide Keyboard & Dropdown
    @objc func hideKeyboardOnTap(_ sender: UITapGestureRecognizer) {
        // Get the tap location relative to the current view
        let location = sender.location(in: view)
        if let tappedView = view.hitTest(location, with: nil) {
                print("   tappedView =", tappedView)
            }
        
        // Detect which view was tapped
        if let tappedView = view.hitTest(location, with: nil),
           // Only trigger if the tap was NOT on the TextField ot Table View Cell
            !(tappedView is UITextField),
            !(tappedView is UITableViewCell),
            !(tappedView is UITableView){
                // Hide the drop-down menu
                locationSearchVC.locationSearchUI.tableViewSearchResults.isHidden = true
            
                // Remove keyboard from screen
                view.endEditing(true)
        }
        
    }
    
    // MARK: - Gesture Recognizer
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // If user tapped TableViewCell or TableView，don't block the cell click
        if touch.view is UITableViewCell || touch.view?.superview is UITableViewCell {
            return false
        }
        return true
    }
    
    // MARK: - Validation (after editing)
    @objc func validateLocationField() {
        
        if isLeavingScreen { return}
        // Screen must be visible
        guard isScreenVisible else { return }
        
        // Add Mode: If user never change the location textfield, skip
        if !statusEditing && didModifyLocation == false {
            return
        }
        
        // Edit Mode: If user doesn't change the rxisted location, no need to validate
        if statusEditing && didModifyLocation == false {
            return
        }
        
        
        // Add mode or user did modify location --> validate
        if !locationSelected {
            screen3UI.textfieldLocation.text = ""
            allergyRecord.location = nil
            showErrorAlert(
                title: "Location Required",
                message: "Please select a location from the dropdown."
            )
        }
    }
    
    // MARK: - Location Selected (Notification)
    @objc func handleLocationSelected(_ notification: Notification) {
        guard let info = notification.userInfo,
              let name = info["name"] as? String,
              let address = info["address"] as? String,
              let lat = info["lat"] as? Double,
              let lon = info["lon"] as? Double else { return }
        
        // Update UI & model
        let location = LocationResult(
                name: name,
                address: address,
                coordinates: CLLocationCoordinate2D(latitude: lat, longitude: lon)
            )
        screen3UI.textfieldLocation.text = name
        allergyRecord.location = location
        locationSelected = true     // Mark as valid selection
        // Hide dropdown after selection
        didModifyLocation = false
        locationSearchVC.view.isHidden = true
        //locationSearchVC.locationSearchUI.tableViewSearchResults.isHidden = true

    }
}
