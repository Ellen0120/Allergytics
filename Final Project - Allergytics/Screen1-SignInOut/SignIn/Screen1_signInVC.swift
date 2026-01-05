//
//  Screen1_signInVC.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 11/4/25.
//

import UIKit
import FirebaseAuth

class Screen1_signInVC: UIViewController {
    
    // MARK: - UI
    let screen1SignInUI = Screen1_signInUI()

    // MARK: - Progress indicator
    let childProgressView = ProgressSpinnerViewController()
    
    // MARK: - LOAD VIEW
    override func loadView() {
        view = screen1SignInUI
    }
    
    
    // MARK: - VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if #available(iOS 18.0, *) {
            tabBarController?.setTabBarHidden(true, animated: animated)
        } else {
            tabBarController?.tabBar.isHidden = true
        }
    }
    
    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors().offwhite
        
        // MARK: Setup Button - Login
        screen1SignInUI.loginButton.addTarget(self,
                                              action: #selector(onLoginButtonTapped),
                                              for: .touchUpInside)
        
        // MARK: Setup Button - Sign up
        screen1SignInUI.signUpButton.addTarget(self,
                                               action: #selector(onSignUpButtonTapped),
                                               for: .touchUpInside)
        
        
        // MARK: Hide Keyboard
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboardOnTap)
        )
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    // MARK: - Add Button Action
    
    // Button - Login
    @objc func onLoginButtonTapped() {
        
        // Unwrap
        let email = screen1SignInUI.emailTextField.text ?? ""
        let password = screen1SignInUI.passwordTextField.text ?? ""
        
        // Validate Input (Screen1_signIn_validation: Empty & Email Format)
        if !validateInputs(email: email,
                           password: password) {
            return
        }
        print("Validated Data Successfully")
        
        // MARK: Show progress indicator
        self.showActivityIndicator()
        
        // MARK: Sign in with Firebase
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showErrorAlert(title: "Login Failed",
                                    message: error.localizedDescription)
                self.hideActivityIndicator()
                return
            }
            self.hideActivityIndicator()
            print("Firebase Login Success: \(email)")
        }
    }
    
    // Button - Sign up
    @objc func onSignUpButtonTapped() {
        let screen1SignUpVC = Screen1_signUpVC()
        navigationController?.pushViewController(screen1SignUpVC, animated: true)
    }
    
    // Hide Keyboard
    @objc func hideKeyboardOnTap() {
        // Remove keyboard from screen
        view.endEditing(true)
    }
    
    
    // MARK: - UI Helper
    func showErrorAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                    style: .default))
        self.present(alertController, animated: true)
    }
}
