//
//  TrendsView.swift
//  Final Project - Allergytics
//
//  Created by Arive Maynes on 11/11/25.
//

import UIKit

class TrendsView: UIView {

    // --- Declare varibles --- //
    // Scroll View
    var scrollView: UIScrollView!

    // Time Menu
    var labelTimeRange: UILabel!
    var buttonTimeMenu: UIButton!
    
    // No Data Label
    var noDataLabel: UILabel!
    
    // Constraints
    var chartsConstraints = [NSLayoutConstraint]()
    var noDataLabelConstraints = [NSLayoutConstraint]()
    
    // Two chart container
    var timeOfDayContainer = TimeOfDateChart_UI()
    var triggerContainer = TriggerChart_UI()
    var symptomContainer = SymptomChart_UI()
    var severityContainer = SeverityChart_UI()
    
    // --- Initialize elements and constraints --- //
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors().offwhite
        setupScrollView()
        setupLabelTimeRange()
        setupButtonTimeMenu()
        setupCharts()
        setupNoDataLabel()
        initConstraints()
    }
    
    // --- Initialize element functions --- //
    // MARK: Scroll View
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }
   
    // MARK: Time Menu
    func setupLabelTimeRange() {
        labelTimeRange = UILabel()
        labelTimeRange.text = "Time Range:"
        labelTimeRange.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        labelTimeRange.textColor = .darkGray
        labelTimeRange.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(labelTimeRange)
    }
    
    func setupButtonTimeMenu() {
        buttonTimeMenu = UIButton(type: .system)
        buttonTimeMenu.setTitle("All Time ▾", for: .normal)
        buttonTimeMenu.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        buttonTimeMenu.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(buttonTimeMenu)
    }
    
    // MARK: Chart
    func setupCharts() {
        
        timeOfDayContainer.translatesAutoresizingMaskIntoConstraints = false
        triggerContainer.translatesAutoresizingMaskIntoConstraints = false
        symptomContainer.translatesAutoresizingMaskIntoConstraints = false
        severityContainer.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(timeOfDayContainer)
        scrollView.addSubview(triggerContainer)
        scrollView.addSubview(symptomContainer)
        scrollView.addSubview(severityContainer)
    }
    
    func setupNoDataLabel() {
        noDataLabel = UILabel()
        noDataLabel.text = "No allergy records to display."
        noDataLabel.textAlignment = .center
        noDataLabel.textColor = .black
        noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        noDataLabel.isHidden = false
        
        scrollView.addSubview(noDataLabel)
    }
    
    
    // --- Constraints --- //
    func initConstraints() {
        noDataLabelConstraints = [
            noDataLabel.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            noDataLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            noDataLabel.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -30),
        ]
        
        chartsConstraints = [
            // Time of Day
            timeOfDayContainer.topAnchor.constraint(equalTo: buttonTimeMenu.bottomAnchor, constant: 15),
            timeOfDayContainer.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 12),
            timeOfDayContainer.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -24),
            

                       // Trigger Chart
            triggerContainer.topAnchor.constraint(equalTo: timeOfDayContainer.bottomAnchor, constant: 40),

            triggerContainer.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 12),
            triggerContainer.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -12),
            triggerContainer.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -24),
            
            // Symptom Chart
            symptomContainer.topAnchor.constraint(equalTo: triggerContainer.bottomAnchor, constant: 40),
            symptomContainer.leadingAnchor.constraint(equalTo: triggerContainer.leadingAnchor),
            symptomContainer.trailingAnchor.constraint(equalTo: triggerContainer.trailingAnchor),
            symptomContainer.widthAnchor.constraint(equalTo: triggerContainer.widthAnchor),
            
            // Severity Chart
            severityContainer.topAnchor.constraint(equalTo: symptomContainer.bottomAnchor, constant: 40),
            severityContainer.leadingAnchor.constraint(equalTo: triggerContainer.leadingAnchor),
            severityContainer.trailingAnchor.constraint(equalTo: triggerContainer.trailingAnchor),
            severityContainer.widthAnchor.constraint(equalTo: triggerContainer.widthAnchor),
            severityContainer.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate([
            // Scroll View
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            // Label - Time Range
            labelTimeRange.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 12),
            labelTimeRange.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -12),
            labelTimeRange.widthAnchor.constraint(equalToConstant: 95),
            
            // Button - Time
            buttonTimeMenu.topAnchor.constraint(equalTo: labelTimeRange.bottomAnchor),
            //buttonTimeMenu.centerYAnchor.constraint(equalTo: labelTimeRange.centerYAnchor),
            buttonTimeMenu.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -12),
        ])
        
        NSLayoutConstraint.activate(noDataLabelConstraints)
    }
    
    
    // MARK: - Required for Storyboard/XIB, not used here (programmatic only)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

