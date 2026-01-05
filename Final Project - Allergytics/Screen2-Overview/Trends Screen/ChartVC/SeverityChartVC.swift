//
//  SeverityChartVC.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 12/1/25.
//

import UIKit
import SwiftUI
import Charts

class SeverityChartVC: UIViewController {

    // --- Define variables --- //
    let chartView = SeverityChart_UI()
    var hostingController: UIHostingController<AnyView>?
    
    // --- Load View --- //
    override func loadView() {
        view = chartView
    }

    func update(with data: [String: Int]) {
        // Clear old chart
        hostingController?.view.removeFromSuperview()
        hostingController = nil
        
        // Convert data
        let names = Array(data.keys)
        let values = Array(data.values).map(Double.init)
        
        // Create stacked bar chart
        let chart = StackedBarChart(
            names: names,
            values: values,
            title: "Severity Distribution"
        )
        

        let host = UIHostingController(rootView: AnyView(chart))
        hostingController = host
        
        print("StackedBarChart RootView =", host.rootView)
        
        hostingController?.view.backgroundColor = .clear
        
        // Add to UI holder
        addChild(host)
        print("Adding hostingController.view to chartHolderView")
        chartView.addSubview(host.view)
        host.didMove(toParent: self)
        
        host.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            host.view.topAnchor.constraint(equalTo: chartView.topAnchor),
            host.view.leadingAnchor.constraint(equalTo: chartView.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: chartView.trailingAnchor),
            host.view.bottomAnchor.constraint(equalTo: chartView.bottomAnchor)
        ])
    }
}

