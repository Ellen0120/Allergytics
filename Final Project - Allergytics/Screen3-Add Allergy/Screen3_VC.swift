//
//  ViewController.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/10/22.
//

import UIKit
import CoreLocation
import FirebaseAuth
import FirebaseFirestore

class Screen3_VC: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    // MARK: - UI Components
    var screen3UI = Screen3_UI()
    var locationSearchVC = LocationSearch_VC()  // Embedded Search View VC as Child View
    
    // MARK: -Data
    let db = Firestore.firestore()
    
    var allergyRecord = AllergyRecord(
        dateTime: Date(),       // Default to current time
        triggers:[],
        symptoms:[],
        severity:"Low",         // Default severity
        location: nil,          // Optional
        additionalNotes: nil    // Optional
    )
    // MARK: - SET LOCATION SELECTED STATUS
    var locationSelected = false    // Track if user picked from dropdown
    var didModifyLocation = false
   
    
    // MARK: - SET EDIT STATUS
    var statusEditing = false
    
    // MARK: - SET VIEW STATUS
    var statusViewing = false
    var receivedRecord: AllergyRecord?
    var isScreenVisible = false     // Flag for error alert
    var isLeavingScreen = false
    
    // MARK: - LOAD VIEW
    override func loadView() {
        view = screen3UI
    }
    
    // MARK: -VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Re-assign delegate every time screen appears
        SearchManager.shared.delegate = locationSearchVC
        
        // Reset the form when user switch back from different tab
        locationSearchVC.view.isHidden = true
        locationSearchVC.results.removeAll()
        locationSearchVC.locationSearchUI.tableViewSearchResults.reloadData()
        
        // Clear location when returning to Add screen (Not Edit page)
        if !statusEditing && !statusViewing{
            
            locationSelected = false
            screen3UI.textfieldLocation.text = ""
            allergyRecord.location = nil
    
        }
    }
    
    // MARK: -VIEW DID APPEAR
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isScreenVisible = true
        isLeavingScreen = false
    }

    // MARK: -VIEW DID DISAPPEAR
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isScreenVisible = false
        view.endEditing(true)
        isLeavingScreen = true
    }
    
    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors().offwhite  // off-white
        
        // MARK: - Add Location Search VC as Child View
        setupLocationSearchVC()
        
        // MARK: Set Text Field Delegate (for typing & searching)
        setTextFieldDelegate()
        
        // MARK: Set Up Button Action (Trigger, Symptom, Save)
        setUpButtonAction()
      
        // MARK: Notification Center (Received Location Selected)
        setUpNotificationCenter()
        
        // MARK: Tap Gesture - Hide Keyboard & Dropdown
        setUpTapGestureRecognizer()
        
        // MARK: Notification Center
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTableSwitch),
            name: .didSwitchTab,
            object: nil
        )
        
        // MARK: Switch Edit & View Mode
        configureMode()
       
    }
    
    
    
    // MARK: - Set Text Field Delegate (for typing & searching)
    func setTextFieldDelegate() {
        screen3UI.textfieldLocation.delegate = self
        // Typing
        screen3UI.textfieldLocation.addTarget(
            self,
            action: #selector(onTextFieldLocationChanged(_:)),
            for: .editingChanged
        )
        // Validate (Return)
        screen3UI.textfieldLocation.addTarget (
            self,
            action: #selector(validateLocationField),
            for: .editingDidEndOnExit
        )
        // Validate (Close the keboard)
        screen3UI.textfieldLocation.addTarget (
            self,
            action: #selector(validateLocationField),
            for: .editingDidEnd
        )
        
        // Retrieve the searching result
        SearchManager.shared.delegate = locationSearchVC
    }
   
    // MARK: - Set Up Notification Center (Received Location Selected)
    func setUpNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleLocationSelected(_:)),
            name: .locationSelected,
            object: nil
        )
    }
   
    // MARK: - Set Up Tap Gesture Recognizer
    func setUpTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboardOnTap)
        )
        // Allow gesture recognizer to check if touch should be handles (e.g., ignore table view cells)
        tapGestureRecognizer.delegate = self
        view.addGestureRecognizer(tapGestureRecognizer)
        
        
    }
   
    
    // MARK: - Set Up Button Action
    func setUpButtonAction() {
        // Checkbox - Trigger
        screen3UI.onTriggerSelectorTapped = { button in
            self.toggleChackbox(for: button)             // Toggle Checkbox Appearance
            self.updateTriggerRecord(from: button)       // Update the data model (AllergyRecord)
        }
        
        // Checkbox - Symptom
        screen3UI.onSymptomSelectorTapped = { button in
            self.toggleChackbox(for: button)            // Toggle Checkbox Appearance
            self.updateSymptomRecord(from: button)      // Update the data model (AllergyRecord)
        }
        
        // Save
        screen3UI.buttonSave.addTarget(self,
                                       action: #selector(onSaveButtonTapped),
                                       for: .touchUpInside)
    }
    
    
    // MARK: - Save Button Action
    @objc func onSaveButtonTapped() {
        
        // Update allergyRecord model
        allergyRecord.dateTime = screen3UI.dateTimePicker.date
        allergyRecord.severity = screen3UI.severityPicker.titleForSegment(at: screen3UI.severityPicker.selectedSegmentIndex) ?? "Low"
        allergyRecord.additionalNotes = screen3UI.textViewAdditionalNotes.text ?? "N/A"
        
        // Validate input (Empty Value: Symptom & Trigger)
        if statusEditing && didModifyLocation == false {
            
        } else {
            let result = ValidationManager.validate(allergyRecord: allergyRecord, locationSelected: locationSelected)
            guard result.isValid else {
                showErrorAlert(title: "Error", message: result.message ?? "Validation Failed")
                return
            }
        }
       
        // Convert to Firestore format
        var recordData: [String: Any] = [
            "dateTime": allergyRecord.dateTime,
            "triggers": allergyRecord.triggers,
            "symptoms": allergyRecord.symptoms,
            "severity": allergyRecord.severity,
            "additionalNotes": allergyRecord.additionalNotes ?? "N/A"
        ]
        
        // Unwrap Location
        if let loc = allergyRecord.location {
            recordData["location"] = [
                "name": loc.name,
                "address": loc.address,
                "latitude": loc.latitude,
                "longitude": loc.longitude
            ]
        }
        saveAllergyRecordToFirebase(data: recordData)
        showSuccessAlertAndNavigate()
        // Reset all UI Fields to default after saving
        resetAllergyForm()
    
    }

   
}

    
 
   
    
  
    
  
    
 
    
    
    
    
