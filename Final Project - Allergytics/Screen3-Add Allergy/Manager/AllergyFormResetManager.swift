//
//  AllergyFormResetManager.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/27.
//

import Foundation
import UIKit

struct AllergyFormResetManager {
    static func resetAllergyForm(in screen3UI: Screen3_UI) {
        screen3UI.dateTimePicker.date = Date()
        screen3UI.severityPicker.selectedSegmentIndex = 0
        screen3UI.textfieldLocation.text = ""
        screen3UI.textViewAdditionalNotes.text = ""
        
        // Reset Triggers
        for button in screen3UI.triggerButtons + screen3UI.symptomButtons {
            button.isSelected = false
            button.setImage(UIImage(systemName: "square"), for: .normal)
            button.tintColor = .darkGray
        }
    }
    
    static func resetModel() -> AllergyRecord {
        return AllergyRecord(
            dateTime: Date(),
            triggers: [],
            symptoms: [],
            severity: "Low",
            location: nil,
            additionalNotes: nil
        )
    }
}



 
