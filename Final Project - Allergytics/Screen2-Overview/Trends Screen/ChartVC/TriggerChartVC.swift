//
//  TriggerChartVC.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/26.
//

import UIKit
import SwiftUI
import Charts

class TriggerChartVC: UIViewController {
    // --- Define variables --- //
    let chartView = TriggerChart_UI()
    var hostingController: UIHostingController<AnyView>?
    
    // --- Load View --- //
    override func loadView() {
        view = chartView
    }
    
    
    // --- Update Data --- //
    func update(with data: [String: Int]) {
        // Clear old chart
        hostingController?.view.removeFromSuperview()
        hostingController = nil
        
        
        
        // Convert data
        let names = Array(data.keys)
        let values = Array(data.values).map(Double.init)
        
        // Create pie chart
        let chart = PieChart(
            names: names,
            values: values,
            title: "Trigger Count Distribution"
        )
        

        let host = UIHostingController(rootView: AnyView(chart))
        hostingController = host
        
        print("PieChart RootView =", host.rootView)
        
        hostingController?.view.backgroundColor = .clear
        
        // Add to UI holder
        addChild(host)
        print("Addinf hostingController.view to chartHolderView")
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
