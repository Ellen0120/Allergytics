//
//  LocationSearch_UI.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/15.
//

import UIKit

class LocationSearch_UI: UIView {

    // MARK: - UI Components
    //var textFieldLocation: UITextField!
    var tableViewSearchResults: UITableView!
    let Screen3UI = Screen3_UI()
    
    // MARK: -Setup elements and constraints
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableViewSearchResults()
        initConstraints()
    }

    // MARK: -UI Method Setup
   
        // Table View
    func setupTableViewSearchResults() {
        tableViewSearchResults = UITableView()
        tableViewSearchResults.isHidden = true      // Hidden
        tableViewSearchResults.backgroundColor = .white
        //tableViewSearchResults.alpha = 0  // Default: Transparent
        tableViewSearchResults.register(LocationSearch_ViewCell.self, forCellReuseIdentifier: "LocationSearchViewCell")
        
        tableViewSearchResults.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewSearchResults)
    }
        // Constraints
    func initConstraints() {
        NSLayoutConstraint.activate([
                // Table View - Search Result
            tableViewSearchResults.topAnchor.constraint(equalTo: self.topAnchor),
            tableViewSearchResults.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableViewSearchResults.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableViewSearchResults.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Required for Storyboard/XIB, not used here (programmatic only)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

