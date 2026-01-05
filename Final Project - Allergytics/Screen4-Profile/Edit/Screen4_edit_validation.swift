//
//  Screen4_edit_validation.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 12/3/25.
//

import UIKit

extension Screen4_editVC {

    func validateInputs(name: String, email: String, phone: String) -> Bool {
        
        // MARK: Empty Validation
        if AccountValidation().isAnyFieldEmptyEdit(name: name, email: email, phone: phone) {
            let alert = AccountValidation().createEmptyAlert()
            self.present(alert, animated: true)
            return false
        }
        
        // MARK: Valid Email Format
        // Error code append
        if !AccountValidation().isValidEmail(email) {
            let alert = AccountValidation().createInvalidEmailAlert()
            self.present(alert, animated: true)
            return false
        }
        
        // MARK: Valid Phone Number
        if !AccountValidation().isValidPhone(phone) {
            let alert = AccountValidation().createInvalidPhoneAlert()
            self.present(alert, animated: true)
            return false
        }
        
        if !AccountValidation().isValidPhoneLength(phone) {
            let alert = AccountValidation().createInvalidPhoneLengthAlert()
            self.present(alert, animated: true)
            return false
        }
        
        return true
    }
    
}
