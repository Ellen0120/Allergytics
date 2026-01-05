//
//  ValidationManager.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/27.
//

import Foundation

struct ValidationResult{
    let isValid: Bool
    let message: String?
}

class ValidationManager {
    static func validate(allergyRecord: AllergyRecord, locationSelected: Bool) -> ValidationResult {
        // Validate trigger & symptoms
        if allergyRecord.triggers.isEmpty || allergyRecord.symptoms.isEmpty {
            return ValidationResult(
                isValid: false,
                message: "Please enter at least one trigger or symptom."
            )
        }
        
        // Final Check for location
        if !locationSelected {
            return ValidationResult(
                isValid: false,
                message: "Please select a location from the dropdown."
            )
        }
        return ValidationResult(isValid: true, message: nil)
    }
}
/*
 // Validate input (Empty Value: Symptom & Trigger)
 if allergyRecord.triggers.isEmpty || allergyRecord.symptoms.isEmpty {
     showErrorAlert(title: "Error",
                    message: "Please enter at least one trigger or symptom."
     )
     return
 }
 */

/*
 @objc func validateLocationField() {
     // Only calidate when this Add screen is actually visible
     guard isScreenVisible else { return }
     
     // If user switched tab or keyboard was dismissed indirectly, skip validation
     guard screen3UI.textfieldLocation.isFirstResponder else { return }
     
     if !locationSelected {
         screen3UI.textfieldLocation.text = ""
         allergyRecord.location = nil
         showErrorAlert(
             title: "Location Required",
             message: "Please select a location from the dropdown."
         )
     }
 }

 */
