//
//  LocationSearch_VC.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/15.
//

import UIKit
import MapKit

class LocationSearch_VC: UIViewController, SearchManagerDelegate {
    
    // MARK: -UI
    var locationSearchUI = LocationSearch_UI()
    
    // MARK: -Data
    var results: [LocationResult] = []

    // MARK: - LOAD VIEW
    override func loadView() {
        view = locationSearchUI
    }
    
    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Set up table delegate and data source
        locationSearchUI.tableViewSearchResults.dataSource = self
        locationSearchUI.tableViewSearchResults.delegate = self
        locationSearchUI.tableViewSearchResults.rowHeight = UITableView.automaticDimension
        locationSearchUI.tableViewSearchResults.estimatedRowHeight = 56
        /*
        // MARK: Delegate
        SearchManager.shared.delegate = self
         */
    }
    
    
    // MARK: - SearchManagerDelegate
    // Called whenever SearchManager finishes a MapKit search
    func didReceiveSearchResults(_ results: [LocationResult]) {
        DispatchQueue.main.async {
            self.results = results
            self.locationSearchUI.tableViewSearchResults.reloadData()
            // Hide table if no results
            let shouldShow = !results.isEmpty
            self.locationSearchUI.tableViewSearchResults.isHidden = !shouldShow
            
            self.view.isUserInteractionEnabled = shouldShow
            if shouldShow {
                self.view.bringSubviewToFront(self.locationSearchUI.tableViewSearchResults)
            }
        }
       
    }
    
    // MARK: -Update Results
    @objc func updateSearchResults(_ notification: Notification) {
        if let newResults = notification.object as? [LocationResult] {
            results = newResults
            
            // Update table view on the main thread
            DispatchQueue.main.async {
                self.locationSearchUI.tableViewSearchResults.reloadData()
                self.locationSearchUI.tableViewSearchResults.isHidden = newResults.isEmpty
                
            }
        }
    }
    
   
}
