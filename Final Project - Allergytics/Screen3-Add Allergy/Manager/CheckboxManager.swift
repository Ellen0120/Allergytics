//
//  CheckboxManager.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/27.
//

import Foundation
import UIKit

class CheckboxManager {
    static let shared = CheckboxManager()
    
    private init() {}
    
    func toggle(_ button: UIButton, selectedColor: UIColor) {
        // Toggle the selection state (true ↔ false)
        button.isSelected.toggle()
        
        // Configure the system image (symbol weight and size)
        let config = UIImage.SymbolConfiguration(weight: .medium)
        
        // Update the button appearance based on selection state
        if button.isSelected {
            // MARK: Selected
            //button.backgroundColor = .clear
            button.tintColor = selectedColor
            let checked = UIImage(systemName: "checkmark.square",
                                  withConfiguration: config)?
                        .withRenderingMode(.alwaysTemplate)
            button.setImage(checked, for: .normal)
            button.setTitleColor(.darkGray, for: .normal)
        } else {
            // MARK: Not Selected
            button.tintColor = .darkGray
            let unchecked = UIImage(systemName: "square",
                                    withConfiguration: config)?
                        .withRenderingMode(.alwaysTemplate)
            button.setImage(unchecked, for: .normal)
            button.setTitleColor(.darkGray, for: .normal)
            //button.backgroundColor = .clear
        }
        
    }
}
/*
 // MARK: - Checkbox Handling
 func toggleChackbox(for button: UIButton) {
     // Toggle the selection state (true ↔ false)
     button.isSelected.toggle()
     
     // Configure the system image (symbol weight and size)
     let config = UIImage.SymbolConfiguration(weight: .medium)
     
     // Update the button appearance based on selection state
     if button.isSelected {
         // MARK: Selected
         button.backgroundColor = .clear
         button.tintColor = Colors().olive
         let checked = UIImage(systemName: "checkmark.square",
                               withConfiguration: config)?
                     .withRenderingMode(.alwaysTemplate)
         button.setImage(checked, for: .normal)
         button.setTitleColor(.darkGray, for: .normal)
     } else {
         // MARK: Not Selected
         button.tintColor = .darkGray
         let unchecked = UIImage(systemName: "square",
                                 withConfiguration: config)?
                     .withRenderingMode(.alwaysTemplate)
         button.setImage(unchecked, for: .normal)
         button.setTitleColor(.darkGray, for: .normal)
         button.backgroundColor = .clear
     }
 }
 
 // --- SELECT A TRIGGER CHECKBOX BUTTON THAT MACTHES THE RECORD --- //
 func selectTrigger(trigger: String) {
     for case let rowStack as UIStackView in screen3UI.triggerContainer.arrangedSubviews {
         for case let button as UIButton in rowStack.arrangedSubviews {
             if button.currentTitle == trigger {
                 toggleChackbox(for: button)
             }
         }
     }
 }
 
 // --- SELECT A SYMPTOM CHECKBOX BUTTON THAT MACTHES THE RECORD --- //
 func selectSymptom(symptom: String) {
     for case let rowStack as UIStackView in screen3UI.symptomsContainer.arrangedSubviews {
         for case let button as UIButton in rowStack.arrangedSubviews {
             if button.currentTitle == symptom {
                 toggleChackbox(for: button)
             }
         }
     }
 }
 */
