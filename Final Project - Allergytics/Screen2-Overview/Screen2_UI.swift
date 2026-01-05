//
//  Screen2_UI.swift
//  Final Project - Allergytics
//
//  Created by Arive Maynes  on 11/11/25.
//

import UIKit

class Screen2_UI: UIView {

    // --- Create elements --- //
    var segmentedControl: UISegmentedControl!         // Element for the tab bar at the top with 3 segments (map, trends, history)
   
    // --- Initialize elements and constraints --- //
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors().offwhite
        setupSegmentedControl()
        initConstraints()
    }
    
    // --- Initialize element functions --- //
    func setupSegmentedControl() {
        segmentedControl = UISegmentedControl(items: ["Map", "Trends", "History"])                  // Set the names of each segment
        segmentedControl.selectedSegmentIndex = 0                                                   // Always start on Map
        segmentedControl.selectedSegmentTintColor =  Colors().olive  // Selected tab background
        let titleTextAttributesNormal = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]  // Config for Unselected text
        let titleTextAttributesSelected = [NSAttributedString.Key.foregroundColor: UIColor.white]   // Config for Selected text
        segmentedControl.setTitleTextAttributes(titleTextAttributesNormal, for: .normal)            // Unselected text
        segmentedControl.setTitleTextAttributes(titleTextAttributesSelected, for: .selected)        // Selected text
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(segmentedControl)
    }
    
    // --- Constraints --- //
    func initConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 2),
            segmentedControl.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            segmentedControl.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
