//
//  Screen3_Editing.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/12/3.
//

import Foundation
import UIKit

extension Screen3_VC {
    
    // MARK: - Configure Editing/ Viewing Mode
    func configureMode() {
        if statusEditing { configureEditingMode()}
        else if statusViewing { congigureViewingMode()}
    }
    
    // EDITING
    private func configureEditingMode() {
        screen3UI.labelTitle.text = "Edit Allergy"
        
        
        // Create Delete Button on top with red icon //
        let trashImage = UIImage(systemName: "trash")?.withRenderingMode(.alwaysTemplate)
        let trashButton = UIBarButtonItem(image: trashImage, style: .plain, target: self, action: #selector(onDeleteButtonTapped))
        trashButton.tintColor = .red
        navigationItem.rightBarButtonItem = trashButton
        
        setAllergyRecordInfo()
    }
    
    // VIEWING
    private func congigureViewingMode() {
        screen3UI.labelTitle.text = "View Allergy"
        
        disableEditing()
        
        // UIBarButtonItem Setup and Action //
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(onEditButtonTapped))
        
        setAllergyRecordInfo()
    }
    // MARK: - In viewing mode, disable editing
    func disableEditing() {
        // Set Elements not Editable //
        screen3UI.dateTimePicker.isEnabled = false
        // disable checkboxes too here so they are not editable !!
        screen3UI.severityPicker.isEnabled = false
        screen3UI.textfieldLocation.isEnabled = false
        screen3UI.textViewAdditionalNotes.isEditable = false
        
        // Hide Save Button and Show Delete Button //
        screen3UI.buttonSave.isHidden = true
        screen3UI.buttonDelete.isHidden = false
        
        
        // Set Delete Action //
        screen3UI.buttonDelete.addTarget(self, action: #selector(onDeleteButtonTapped), for: .touchUpInside) // Add button action
        
        
        // Disable trigger buttons //
        for case let rowStack as UIStackView in screen3UI.triggerContainer.arrangedSubviews {
            for case let button as UIButton in rowStack.arrangedSubviews {
                button.isEnabled = false
            }
        }
        
        // Disable symptom buttons //
        for case let rowStack as UIStackView in screen3UI.symptomsContainer.arrangedSubviews {
            for case let button as UIButton in rowStack.arrangedSubviews {
                button.isEnabled = false
            }
        }
    }
    
    // --- MARK: (EDIT PAGE) REFLECT THE RECORD INFORMATION TO THE UI --- //
    func setAllergyRecordInfo() {
        if let record = receivedRecord {
            // Set date / time
            screen3UI.dateTimePicker.date = record.dateTime
            
            // Check triggers
            for trigger in record.triggers {
                selectTrigger(trigger: trigger)
            }
            
            // Check symptoms
            for symptom in record.symptoms {
                selectSymptom(symptom: symptom)
            }
            
            // Set severity
            screen3UI.severityPicker.selectedSegmentIndex = screen3UI.severityOptions
                .firstIndex(of: record.severity) ?? 0
            
            // Set location
            screen3UI.textfieldLocation.text = record.location?.name
            locationSelected = true  // Since in edit mode we already have a location, mark it as selected

            
            // Set notes
            screen3UI.textViewAdditionalNotes.text = record.additionalNotes
            
            // Set allergyRecord
            allergyRecord = record
        } else {
            print("No allergy record received!")
        }
    }
    
    // --- MARK: (EDIT PAGE) SELECT A TRIGGER CHECKBOX BUTTON THAT MACTHES THE RECORD --- //
    func selectTrigger(trigger: String) {
        for case let rowStack as UIStackView in screen3UI.triggerContainer.arrangedSubviews {
            for case let button as UIButton in rowStack.arrangedSubviews {
                if button.currentTitle == trigger {
                    toggleChackbox(for: button)
                }
            }
        }
    }
    
    // --- MARK: (EDIT PAGE) SELECT A SYMPTOM CHECKBOX BUTTON THAT MACTHES THE RECORD --- //
    func selectSymptom(symptom: String) {
        for case let rowStack as UIStackView in screen3UI.symptomsContainer.arrangedSubviews {
            for case let button as UIButton in rowStack.arrangedSubviews {
                if button.currentTitle == symptom {
                    toggleChackbox(for: button)
                }
            }
        }
    }
    
    // --- MARK: (EDIT PAGE) EDIT BUTTON ACTION --- //
    @objc func onEditButtonTapped(){
        //let editAllergyController = EditViewController()
        let editAllergyController = Screen3_VC()
        editAllergyController.receivedRecord = self.receivedRecord
        editAllergyController.statusEditing = true
        navigationController?.pushViewController(editAllergyController, animated: true)
        }
    
    // --- MARK: (EDIT PAGE) DELETE BUTTON ACTION --- //
    @objc func onDeleteButtonTapped(){
        alertforconfirmation()
    }
    
    func alertforconfirmation() {                                                    // Show an alert for confirmation
        let alert = UIAlertController(title: "Delete Allergy", message: "Are you sure you want to delete this entry?",preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Delete", style: .destructive) { _ in   // if user selects YES
            print("DELETINNNG")
            RecordManager().deleteRecord(record: self.receivedRecord)                                                      // delete record
            self.navigationController?.popToRootViewController(animated: true)       // go back to main screen
        }
        let noAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)  // if user selects No THEN WE DO NOTHING
        alert.addAction(yesAction)                                     // add the action for when user clicks on Yes = delete
        alert.addAction(noAction)                                      // add the action for when user clicks on No = do nothig
        self.present(alert, animated: true, completion: nil)           // display the alert
    }
    
}
