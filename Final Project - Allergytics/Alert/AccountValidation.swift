//
//  AccountValidation.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 11/23/25.
//

import Foundation
import UIKit

struct AccountValidation {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPhoneLength(_ phone: String) -> Bool {
        if phone.count != 10 {
            return false
        } else {
            return true
        }
    }
    
    func isValidPhone(_ phone: String) -> Bool {
        if Int(phone) == nil {
            return false
        } else {
            return true
        }
    }
    
    func isPasswordMatching(password1: String, password2: String) -> Bool {
        return password1 == password2
    }
    
    func isAnyFieldEmptySignUp(name: String, email: String, phone: String, password: String) -> Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func isAnyFieldEmptyEdit(name: String, email: String, phone: String) -> Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func createErrorAlert(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                    style: .default))
        return alertController
    }
    
    func createPasswordNotMatchingAlert() -> UIAlertController {
        let alert = createErrorAlert(title: "Password does not match", message: "Please make sure that both passwords match.")
        return alert
    }
    
    func createDuplicateEmailAlert() -> UIAlertController {
        let alert = createErrorAlert(title: "Email already in use", message: "This email is already used by another user.")
        return alert
    }
    
    func createUserNotFoundAlert() -> UIAlertController {
        let alert = createErrorAlert(title: "User not found", message: "User account with the entered email and password was not found.")
        return alert
    }
    
    func createWrongPasswordAlert() -> UIAlertController {
        let alert = createErrorAlert(title: "Wrong password", message: "Please enter correct password.")
        return alert
    }
    
    func createInvalidEmailAlert() -> UIAlertController {
        let alert = createErrorAlert(title: "Invalid email", message: "Please enter valid email.")
        return alert
    }
    
    func createInvalidPhoneLengthAlert() -> UIAlertController {
        let alert = createErrorAlert(title: "Invalid phone number length", message: "Phone Number must be 10 digits long.")
        return alert
    }
    
    func createInvalidPhoneAlert() -> UIAlertController {
        let alert = createErrorAlert(title: "Invalid phone number", message: "Phone number must contain only digits")
        return alert
    }
    
    func createEmptyAlert() -> UIAlertController {
        let alert = createErrorAlert(title: "Empty fields", message: "Please fill out all fields.")
        return alert
    }
}
