//
//  HistoryViewController.swift
//  Final Project - Allergytics
//
//  Created by Arive Maynes  on 11/11/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HistoryViewController: UIViewController {
    
    // --- Declare varibles --- //
    let HistoryScreen = HistoryView()                // connect with my view for the first screen
    var historylist = [AllergyRecord]()                // To store the History information we have in Firebase and show on table
    
    // --- Firebase --- //
    let db = Firestore.firestore()
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    // -- Notification -- //
    let notificationCenter = NotificationCenter.default  // Set up the notification
    
    // --- Load View --- //
    override func loadView() { view = HistoryScreen  }
    
    // --- View Will Appear --- //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Deselect the highlighted row
        if let indexPath = HistoryScreen.usersTable.indexPathForSelectedRow {
            HistoryScreen.usersTable.deselectRow(at: indexPath, animated: true)
            }
    }
    
    // --- View Did Load --- //
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Allergy History"
        self.view.backgroundColor = Colors().offwhite
        HistoryScreen.usersTable.dataSource = self                          // Setting the delegate and data source for table view
        HistoryScreen.usersTable.delegate = self                            // Setting the delegate and data source for table view
        HistoryScreen.usersTable.separatorStyle = .none                     // Removing the separator line for table view
        HistoryScreen.usersTable.rowHeight = UITableView.automaticDimension // So it accepts auto dimension for larger texts
        HistoryScreen.usersTable.estimatedRowHeight = 60                    // Start on a estimated heighet
        
        historylist = HistoryStore.shared.history
        
        notificationCenter.addObserver(self, selector: #selector(onRecordReloaded), name: .recordReloaded, object: nil)
        
        onRecordReloaded()
    }
    
    @objc func onRecordReloaded() {
        historylist = HistoryStore.shared.history
        if historylist.count > 0 {
            HistoryScreen.noDataLabel.isHidden = true
            NSLayoutConstraint.activate(HistoryScreen.tableConstraints)
            NSLayoutConstraint.deactivate(HistoryScreen.dataLabelConstraints)
        } else {
            HistoryScreen.noDataLabel.isHidden = false
            NSLayoutConstraint.deactivate(HistoryScreen.tableConstraints)
            NSLayoutConstraint.activate(HistoryScreen.dataLabelConstraints)
        }
        HistoryScreen.usersTable.reloadData()
        print("History list reloaded")
    }
}

// ------------------------------------------------------------------------------------------------------ //
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    // MARK: NUM OF ROWS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return historylist.count  }
    
    
    // MARK: CELL FOR ROW AT
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Filling Table with Info //
        let record = historylist[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "history", for: indexPath) as! HistoryTableView
        let triggerText = record.triggers.joined(separator: ",")
        let symptomsText = record.symptoms.joined(separator: ",")
        let locationText = record.location?.name ?? "Unknown"
        cell.labelTrigger.text = "Trigger: \(triggerText)"
        cell.labelSymptoms.text = "Symptoms: \(symptomsText)"
        cell.labelLocation.text = locationText
        let calendar = Calendar.current
        let today = Date()
        if calendar.isDate(record.dateTime, inSameDayAs: today) { cell.labelDate.text = "Today"
        } else if let yesterday = calendar.date(byAdding: .day, value: -1, to: today),
            calendar.isDate(record.dateTime, inSameDayAs: yesterday) { cell.labelDate.text = "Yesterday"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"
            cell.labelDate.text = formatter.string(from: record.dateTime)
        }
        
        // Crafting an accessory button //
        let buttonOptions = UIButton(type: .system)           // set this elment as an UIButton
        buttonOptions.sizeToFit()                             // ask the button to size to fit the cell's width
        buttonOptions.showsMenuAsPrimaryAction = true
        let congif = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular)  // Setting an icon from sf symbols
        buttonOptions.setImage(UIImage(systemName: "ellipsis.circle",  withConfiguration: congif ), for: .normal)
        buttonOptions.tintColor = .black                      // Make it black
        buttonOptions.menu = UIMenu(
           children: [ UIAction(title: "Edit Allergy", image: UIImage(systemName: "pencil"),
                                handler: {(_) in
                                    //let editAllergyController = EditViewController()
                                    //editAllergyController.receivedRecord = record
                                    let editAllergyController = Screen3_VC()
                                    editAllergyController.receivedRecord = record
                                    editAllergyController.statusEditing = true
                                    self.navigationController?.pushViewController(editAllergyController, animated: true) }),
                       UIAction(title: "Delete Allergy", image: UIImage(systemName: "trash"), attributes: .destructive,
                                handler: {(_) in
                                    // RecordManager().deleteRecord(record: record)
                                    let alert = UIAlertController(title: "Delete Allergy", message: "Are you sure you want to delete this entry?",preferredStyle: .alert)
                                    let yesAction = UIAlertAction(title: "Delete", style: .destructive) { _ in   // if user selects YES
                                        print("DELETINNNG")
                                        RecordManager().deleteRecord(record: record)                                                      // delete record
                                        self.navigationController?.popToRootViewController(animated: true)       // go back to main screen
                                    }
                                    let noAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)  // if user selects No THEN WE DO NOTHING
                                    alert.addAction(yesAction)                                     // add the action for when user clicks on Yes = delete
                                    alert.addAction(noAction)                                      // add the action for when user clicks on No = do nothig
                                    self.present(alert, animated: true, completion: nil)           // display the alert
                                })
           ])
        cell.accessoryView = buttonOptions                    // Setting the button as an accessory of the cell
        
        // Alternate Cell Background Colors //
        if indexPath.row % 2 == 0 {
            cell.wrapperCellView.backgroundColor = Colors().palegreen // Pale green + Black text
            cell.labelDate.textColor = UIColor.black
            cell.labelTrigger.textColor = UIColor.black
            cell.labelSymptoms.textColor = UIColor.black
            cell.labelLocation.textColor = UIColor.black
        } else {
            cell.wrapperCellView.backgroundColor = Colors().olive   // Olive green + White text
            cell.labelDate.textColor = UIColor.white
            cell.labelTrigger.textColor = UIColor.white
            cell.labelSymptoms.textColor = UIColor.white
            cell.labelLocation.textColor = UIColor.white
        }
        
        return cell
    }
    
    
    // MARK: DID SELECT
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // Open Details View
        let viewAllergyController = Screen3_VC()
        viewAllergyController.statusViewing = true
        viewAllergyController.receivedRecord = historylist[indexPath.row]
        navigationController?.pushViewController(viewAllergyController, animated: true)
    }
    
}
