//
//  SearchManager.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/19.
//

import Foundation
import MapKit


// MARK: - Delegate Protocol
protocol SearchManagerDelegate: AnyObject {
    func didReceiveSearchResults(_ results: [LocationResult])
}

// MARK: - Search Manager
class SearchManager {
    static let shared = SearchManager()
    var delegate: SearchManagerDelegate?
    
    var currentSearch: MKLocalSearch?
    var lastRequestTime = Date.distantPast
    let minSearchInterval: TimeInterval = 0.8
    
    func searchLocation(for query: String) {
        // Skip same or empty query
        let trimmed = query.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {
            delegate?.didReceiveSearchResults([])
            return
        }

        // MARK: Send Request
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        let search = MKLocalSearch(request: request)
        currentSearch = search
        
        print("Searching for: \(query)")
        
        search.start { response, error in
            // Ignore cancelled requests
            if let nsError = error as NSError?,
               nsError.domain == "MKErrorDomain", nsError.code == 4 {return }
            
            
            guard let response = response else {
                print("MapKit error: \(error?.localizedDescription ?? "Unknown")")
                self.delegate?.didReceiveSearchResults([])
                return
            }
            
            let results = response.mapItems.map {
                LocationResult(
                    name: $0.name ?? "Unknown Location",
                    address: $0.placemark.title ?? "" ,
                    coordinates: $0.placemark.coordinate
                )
            }
            
            //print("Found \(results.count) results")
            DispatchQueue.main.async{
                self.delegate?.didReceiveSearchResults(results)
            }
        }
    }
}
