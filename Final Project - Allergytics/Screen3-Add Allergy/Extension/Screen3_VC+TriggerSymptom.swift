//
//  Screen3_VC+TriggerSymptom.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/12/3.
//

import Foundation
import UIKit

extension Screen3_VC {
    // MARK: - Checkbox Handling
    func toggleChackbox(for button: UIButton) {
        CheckboxManager.shared.toggle(button, selectedColor: Colors().olive)
    }
    
    // MARK: Update Trigger String
    func updateTriggerRecord(from button: UIButton) {
        guard let title = button.titleLabel?.text else { return }
        if button.isSelected {
            allergyRecord.triggers.append(title)
        } else {
            // Remove all elements from the array that match the deselected button title
            allergyRecord.triggers.removeAll { $0 == title }
        }
    }
    
    // MARK: Update Symptom String
    func updateSymptomRecord(from button: UIButton) {
        guard let title = button.titleLabel?.text else { return }
        if button.isSelected {
            allergyRecord.symptoms.append(title)
        } else {
            allergyRecord.symptoms.removeAll { $0 == title }
        }
    }
}
