//
//  LocationSearchCellManager.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/15.
//

import Foundation
import UIKit

extension LocationSearch_VC: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: NUMBERS OF ROWS IN SECTION
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
        
    }
    
    // MARK: CELL FOR ROW AT
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationSearchViewCell", for: indexPath) as! LocationSearch_ViewCell
        let result = results[indexPath.row]
        
        // Set cell labels
        cell.labelTitle.text = result.name
        cell.labelSubtitle.text = result.address
        return cell
        
    }
    
    // MARK: DID SELECT ROW AT
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = results[indexPath.row]
        
        // Notify Screen3_VC about the selected location -> Update textfield
        NotificationCenter.default.post(
            name: .locationSelected,
            object: nil,
            userInfo: [
                "name": selectedResult.name,
                "address": selectedResult.address,
                "lat": selectedResult.latitude,
                "lon": selectedResult.longitude
            ]
        )
        
        // Deselect & hide dropdown
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.isHidden = true
        view.endEditing(true)
        
    }
    
}
