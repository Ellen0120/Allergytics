//
//  Screen1_signUp_validation.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/9.
//

import Foundation

extension Screen1_signUpVC {
    
    func validateInputs(name: String, email: String, phone: String, password: String) -> Bool {
        
        // MARK: Empty Validation
        if AccountValidation().isAnyFieldEmptySignUp(name: name, email: email, phone: phone, password: password){
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
