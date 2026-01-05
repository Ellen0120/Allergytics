//
//  TrendsViewController.swift
//  Final Project - Allergytics
//
//  Created by Arive Maynes on 11/11/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class TrendsViewController: UIViewController {

    // --- Declare varibles --- //
    let TrendsScreen = TrendsView()                                                       // connect with my view for the first screen
    let timeOfDayVC = TimeofDayChartVC()
    let triggerVC = TriggerChartVC()
    let symptomVC = SymptomChartVC()
    let severityVC = SeverityChartVC()
    
    var originalRecords: [AllergyRecord] = []
    var allRecords: [AllergyRecord] = []    // Save the record that was fetched from firebase
    
    // --- Notificaion Center --- //
    let notificationCenter = NotificationCenter.default
    
    
    // --- Load View --- //
    override func loadView() { view = TrendsScreen  }
    
    // --- View Did Load --- //
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trends Graphs"
        self.view.backgroundColor = Colors().offwhite
        
        // MARK: Add Child View
        addChildVCs()
        
        // MARK: Load Data
        loadData()
        
        // MARK: Time Range Menu
        setupTimeRangeMenu()
    }
    
    // MARK: -Add Child VC
    func addChildVCs() {
        // Time of Day
        addChild(timeOfDayVC)
        TrendsScreen.timeOfDayContainer.addSubview(timeOfDayVC.view)
        timeOfDayVC.didMove(toParent: self)
        timeOfDayVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeOfDayVC.view.topAnchor.constraint(equalTo: TrendsScreen.timeOfDayContainer.topAnchor),
            timeOfDayVC.view.leadingAnchor.constraint(equalTo: TrendsScreen.timeOfDayContainer.leadingAnchor),
            timeOfDayVC.view.trailingAnchor.constraint(equalTo: TrendsScreen.timeOfDayContainer.trailingAnchor),
            timeOfDayVC.view.bottomAnchor.constraint(equalTo: TrendsScreen.timeOfDayContainer.bottomAnchor)
            
        ])
        
        // Trigger Count
        addChild(triggerVC)
        TrendsScreen.triggerContainer.addSubview(triggerVC.view)
        triggerVC.didMove(toParent: self)
        triggerVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            triggerVC.view.topAnchor.constraint(equalTo: TrendsScreen.triggerContainer.topAnchor),
            triggerVC.view.leadingAnchor.constraint(equalTo: TrendsScreen.triggerContainer.leadingAnchor),
            triggerVC.view.trailingAnchor.constraint(equalTo: TrendsScreen.triggerContainer.trailingAnchor),
            triggerVC.view.bottomAnchor.constraint(equalTo: TrendsScreen.triggerContainer.bottomAnchor)
        ])
        
        // Symptom Count
        addChild(symptomVC)
        TrendsScreen.symptomContainer.addSubview(symptomVC.view)
        symptomVC.didMove(toParent: self)
        symptomVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            symptomVC.view.topAnchor.constraint(equalTo: TrendsScreen.symptomContainer.topAnchor),
            symptomVC.view.leadingAnchor.constraint(equalTo: TrendsScreen.symptomContainer.leadingAnchor),
            symptomVC.view.trailingAnchor.constraint(equalTo: TrendsScreen.symptomContainer.trailingAnchor),
            symptomVC.view.bottomAnchor.constraint(equalTo: TrendsScreen.symptomContainer.bottomAnchor)
        ])
        
        // Severity
        addChild(severityVC)
        TrendsScreen.severityContainer.addSubview(severityVC.view)
        severityVC.didMove(toParent: self)
        severityVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            severityVC.view.topAnchor.constraint(equalTo: TrendsScreen.severityContainer.topAnchor),
            severityVC.view.leadingAnchor.constraint(equalTo: TrendsScreen.severityContainer.leadingAnchor),
            severityVC.view.trailingAnchor.constraint(equalTo: TrendsScreen.severityContainer.trailingAnchor),
            severityVC.view.bottomAnchor.constraint(equalTo: TrendsScreen.severityContainer.bottomAnchor)
        ])
    }
    // MARK: -Load Data
    func loadData() {
        let uid = Auth.auth().currentUser?.uid ?? ""
        
        notificationCenter.addObserver(
            self,
            selector: #selector(onRecordReloaded),
            name: .recordReloaded,
            object: nil
        )
        onRecordReloaded()
    }
    
    @objc func onRecordReloaded() {
        var records: [AllergyRecord] = []
        records = HistoryStore.shared.history
        self.originalRecords = records
        self.allRecords = records
        
        // If no record is available, hide charts and show no data label
        if self.allRecords.count > 0 {
            TrendsScreen.noDataLabel.isHidden = true
            TrendsScreen.timeOfDayContainer.isHidden = false
            TrendsScreen.triggerContainer.isHidden = false
            TrendsScreen.symptomContainer.isHidden = false
            TrendsScreen.severityContainer.isHidden = false
            NSLayoutConstraint.activate(TrendsScreen.chartsConstraints)
            NSLayoutConstraint.deactivate(TrendsScreen.noDataLabelConstraints)
        } else {
            TrendsScreen.noDataLabel.isHidden = false
            TrendsScreen.timeOfDayContainer.isHidden = true
            TrendsScreen.triggerContainer.isHidden = true
            TrendsScreen.symptomContainer.isHidden = true
            TrendsScreen.severityContainer.isHidden = true
            NSLayoutConstraint.deactivate(TrendsScreen.chartsConstraints)
            NSLayoutConstraint.activate(TrendsScreen.noDataLabelConstraints)
        }
        self.updateCharts()
    }
    
    func updateCharts() {
        // Process the data
        let timeofDayData = DataProcessor.processTimeofDay(allRecords)
        let triggerCountData = DataProcessor.processTrigger(allRecords)
        let symptomCountData = DataProcessor.processSymptom(allRecords)
        let severityCountData = DataProcessor.processSeverity(allRecords)
        
        // Pass the data to subview
        timeOfDayVC.update(with: timeofDayData)
        triggerVC.update(with: triggerCountData)
        symptomVC.update(with: symptomCountData)
        severityVC.update(with: severityCountData)
    }
    
    // MARK: -Setup Time Range Menu
    func setupTimeRangeMenu() {
        let menu = UIMenu(title: "Select Time Range", children: [
                UIAction(title: "All Time") { _ in
                    self.didSelectRange("All Time", key: "all")
                },
                UIAction(title: "Today") { _ in
                    self.didSelectRange("Today", key: "today")
                },
                UIAction(title: "Last 7 Days") { _ in
                    self.didSelectRange("Last 7 Days", key: "7d")
                },
                UIAction(title: "Last 30 Days") { _ in
                    self.didSelectRange("Last 30 Days", key: "30d")
                },
                UIAction(title: "Last 90 Days") { _ in
                    self.didSelectRange("Last 90 Days", key: "90d")
                },
                UIAction(title: "Last 6 Months") { _ in
                    self.didSelectRange("Last 6 Months", key: "6m")
                },
                UIAction(title: "Last 12 Months") { _ in
                    self.didSelectRange("Last 12 Months", key: "12m")
                }
            ])
        
        // Attach the menu to the button in TrendsView
        TrendsScreen.buttonTimeMenu.menu = menu
        TrendsScreen.buttonTimeMenu.showsMenuAsPrimaryAction = true
    }
    
    func didSelectRange(_ title: String, key: String) {
        TrendsScreen.buttonTimeMenu.setTitle("\(title) ▾", for: .normal)
        
        // Update Stored Records
        self.allRecords = TimeRangeFilter.filterRecords(originalRecords, by: key)
        
        // Refresh Two Charts
        updateCharts()
    }
    
   
}
