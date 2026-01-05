//
//  ProgressSpinnerViewController.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 12/8/25.
//

import UIKit

class ProgressSpinnerViewController: UIViewController {
    
    // MARK: - Define activity indicator
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - Set UI elements
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        
        // MARK: - Set view
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        view.addSubview(activityIndicator)
        
        // MARK: - Set constraints
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
