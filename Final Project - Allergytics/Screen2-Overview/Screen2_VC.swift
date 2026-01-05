//
//  Screen 2_VC.swift
//  Final Project - Allergytics
//
//  Created by Arive Maynes  on 11/11/25.
//

import UIKit

class Screen2_VC: UIViewController {

    // --- Define variables --- //
    var tabsScreen = Screen2_UI()           // connect with my view for the overview screen
    var currentChildVC: UIViewController?   // Store the current child, so we replace them with segment control
    
    // --- Load View --- //
    override func loadView() { view = tabsScreen }
    
    // --- View Did Load --- //
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors().offwhite                     // Set background color off-white
        navigationItem.largeTitleDisplayMode = .never // Dismiss large title so it doesnt move to the top
        tabsScreen.segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged) // Action for tap on segment control
        segmentChanged()                                                                                   // Load the first tab when we start
    }
    
    // --- Switching Screens --- //
    @objc func segmentChanged() {
        // Define parent as current view controller //
        let parentVC = self
        // Remove current child //
        if let current = currentChildVC { current.willMove(toParent: nil); current.view.removeFromSuperview(); current.removeFromParent() }
        // Create new child based on selection //
        let newVC: UIViewController                               // Define our new viewcontroller of type view controller
        switch tabsScreen.segmentedControl.selectedSegmentIndex { // Depending on what we select on segmentedcontroll is the screen we go to
        case 0: newVC = MapViewController()                       // First Tab == MAP VIEW
        case 1: newVC = TrendsViewController()                    // Second Tab == TREND VIEW
        case 2: newVC = HistoryViewController()                   // Third Tab == HISTORY VIEW
        default: return
        }
        // Add new child //
        parentVC.addChild(newVC)                                  // Child is whatever option we chose on segmented control
        newVC.view.translatesAutoresizingMaskIntoConstraints = false  // Part if initial setup for the view
        tabsScreen.addSubview(newVC.view)                             // Part of initial setup for the view
        // Set their constraints //
        NSLayoutConstraint.activate([
            newVC.view.topAnchor.constraint(equalTo: tabsScreen.segmentedControl.bottomAnchor, constant: 16),
            newVC.view.leadingAnchor.constraint(equalTo: tabsScreen.safeAreaLayoutGuide.leadingAnchor),
            newVC.view.trailingAnchor.constraint(equalTo: tabsScreen.safeAreaLayoutGuide.trailingAnchor),
            newVC.view.bottomAnchor.constraint(equalTo: tabsScreen.safeAreaLayoutGuide.bottomAnchor)
        ])
        newVC.didMove(toParent: parentVC)
        currentChildVC = newVC
    }
    
}
