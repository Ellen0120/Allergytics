//
//  TabBar_VC.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/10/29.
//

import UIKit

class TabBar_VC: UITabBarController, UITabBarControllerDelegate {

    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupTabs()
    }
    
    // MARK: - Notification Center (Switch tab)
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        NotificationCenter.default.post(name: .didSwitchTab, object: nil)
    }
    
    
    // MARK: - Required for Storyboard/XIB, not used here (programmatic only)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        }
    
    init() {
            super.init(nibName: nil, bundle: nil)
        }
    
    func setupTabs() {
        // MARK: TAB 1: Overview
        let tabOverview = UINavigationController(rootViewController: Screen2_VC())
        let tabOverviewBarItem = UITabBarItem(title: "Overview",
                                           image: UIImage(systemName: "chart.line.text.clipboard"),            // Un-Selected
                                           selectedImage: UIImage(systemName:"chart.line.text.clipboard.fill") // Selected
                                           )
        tabOverview.tabBarItem = tabOverviewBarItem
        tabOverview.title = "Overview"
        
        // MARK: - TAB 2: Add Allergy
        let tabAddAllergy = UINavigationController(rootViewController: Screen3_VC())
        let tabAddAllergyBarItem = UITabBarItem(title: "Add",
                                              image: UIImage(systemName: "plus.circle"),            // Un-Selected
                                              selectedImage: UIImage(systemName:"plus.circle.fill") // Selected
        )
        tabAddAllergy.tabBarItem = tabAddAllergyBarItem
        tabAddAllergy.title = "Add"
        
        // MARK: - TAB 3: Profile
        let tabProfile = UINavigationController(rootViewController: Screen4_VC())
        let tabProfileBarItem = UITabBarItem(title: "Profile",
                                              image: UIImage(systemName: "person"),
                                              selectedImage: UIImage(systemName:"person.fill")
        )
        tabProfile.tabBarItem = tabProfileBarItem
        tabProfile.title = "Profile"
        
        // MARK: Set up the VC as the Tab Bar Controller
        self.viewControllers = [tabOverview, tabAddAllergy, tabProfile]
        
        // MARK: Set the Overview as first pop up screen
        self.selectedIndex = 0

    }
}
