//
//  HistoryView.swift
//  Final Project - Allergytics
//
//  Created by Arive Maynes on 11/11/25.
//

import UIKit

class HistoryView: UIView {

    // --- Create elements for screen --- //
    var usersTable: UITableView!
    var noDataLabel: UILabel!
    
    // --- Constraints --- //
    var tableConstraints = [NSLayoutConstraint]()
    var dataLabelConstraints = [NSLayoutConstraint]()
    
    // --- Initialize elemetns and constraints --- //
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors().offwhite
        setupuserstable()
        setupNoDataLabel()
        initConstraints()
    }
    
    // --- Initialize element functions --- //
    func setupuserstable(){
        usersTable = UITableView()
        usersTable.backgroundColor = Colors().offwhite
        usersTable.register(HistoryTableView.self, forCellReuseIdentifier: "history")
        usersTable.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(usersTable)
    }
    
    func setupNoDataLabel() {
        noDataLabel = UILabel()
        noDataLabel.text = "No allergy records to display."
        noDataLabel.textAlignment = .center
        noDataLabel.textColor = .black
        noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        noDataLabel.isHidden = false
        
        self.addSubview(noDataLabel)
    }
    
    // --- Constraints --- //
    func initConstraints(){
        tableConstraints = [
            usersTable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            usersTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            usersTable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            usersTable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -4),
        ]
        dataLabelConstraints = [
            noDataLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            noDataLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            noDataLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(
            dataLabelConstraints
        )
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    

}
