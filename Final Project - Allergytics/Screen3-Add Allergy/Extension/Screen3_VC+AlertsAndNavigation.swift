//
//  Screen3_VC+AlertsAndNavigation.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/12/3.
//

import Foundation
import UIKit

extension Screen3_VC {
    
    // MARK: - Error Alert and navigate to tab 0's root screen
    func showErrorAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    // MARK: - Show Success Alert
    func showSuccessAlertAndNavigate() {
        let alert = UIAlertController(
            title: "Success",
            message: "Allergy Record Saved!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            
            // Navigatation after save
            if self.statusEditing {
                // After Edit --> History
                if let tabBar = self.tabBarController,
                   let nav0 = tabBar.viewControllers?.first as? UINavigationController,
                   let overviewVC = nav0.viewControllers.first as? Screen2_VC {
                    // Switch to Overview tab
                    tabBar.selectedIndex = 0
                    nav0.popToRootViewController(animated: false)
                    
                    // Switch the segment
                    overviewVC.tabsScreen.segmentedControl.selectedSegmentIndex = 2
                    overviewVC.segmentChanged()
                    }
                
            } else {
                // Add → Overview
                if let tabBar = self.tabBarController,
                    let nav0 = tabBar.viewControllers?.first as? UINavigationController,
                    let overviewVC = nav0.viewControllers.first as? Screen2_VC{
                    // Navigate to overview
                    tabBar.selectedIndex = 0
                    nav0.popToRootViewController(animated: false)
                    
                    // Switch the segment
                    overviewVC.tabsScreen.segmentedControl.selectedSegmentIndex = 0
                    overviewVC.segmentChanged()
                }
            }
        }))
        self.present(alert, animated: true)
    }
    
    // MARK: Reset Allergy Form
    func resetAllergyForm() {
        AllergyFormResetManager.resetAllergyForm(in: screen3UI)
        allergyRecord = AllergyFormResetManager.resetModel()
        
        locationSelected = false
        print("Reset complete.")
    }
    
    // MARK: Handle Tab Switch
    @objc func handleTableSwitch() {
        isLeavingScreen = true
    }
    
}
