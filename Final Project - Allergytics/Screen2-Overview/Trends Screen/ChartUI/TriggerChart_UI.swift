//
//  TriggerChart_UI.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/26.
//

import UIKit

class TriggerChart_UI: UIView {

    // --- Create elements --- //
    //var chartHolderView = UIView()
   
    // --- Initialize elements and constraints --- //
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        //setupChartHolderView()
        //initConstraints()
    }
/*
    func setupChartHolderView() {
        chartHolderView = UIView()
        chartHolderView.backgroundColor = .clear
        chartHolderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(chartHolderView)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            chartHolderView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            chartHolderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            chartHolderView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            chartHolderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            //chartHolderView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
*/
    // MARK: - Required for Storyboard/XIB, not used here (programmatic only)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
