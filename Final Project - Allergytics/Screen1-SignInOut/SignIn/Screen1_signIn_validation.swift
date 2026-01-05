//
//  Screen1_signIn_validation.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/9.
//

import Foundation

extension Screen1_signInVC {
    
    func validateInputs(email: String, password: String) -> Bool {
        
        // MARK: Empty Validation
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showErrorAlert(title: "Error", message: "Please fill all fields")
            return false
        }
        
        // MARK: Valid Email Format
        // Define a regex pattern for valid email format
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        // Create a predicate to check if the input matches the regex
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        // Error code append
        if !emailPred.evaluate(with: email) {
            showErrorAlert(title: "Error", message:"Invalid Email Format")
            return false
        }
        return true
    }
    
    
}
