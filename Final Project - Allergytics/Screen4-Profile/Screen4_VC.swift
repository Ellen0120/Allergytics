//
//  Screen 4_VC.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/10/29.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class Screen4_VC: UIViewController {

    // MARK: -UI
    var screen4UI = Screen4_UI()
    let screen1SignIn = Screen1_signInVC()
    
    // MARK: - Firebase
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    
    // MARK: - Notification
    let notificationCenter = NotificationCenter.default
    
    // MARK: - Progress indicator view
    let childProgressView = ProgressSpinnerViewController()
    
    // MARK: - LOAD VIEW
    override func loadView() {
        view = screen4UI
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors().offwhite
        
        // MARK: Set up Navigation Bar Button - Edit
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit, target: self, action: #selector(onEditButtonTapped)
        )
        
        // MARK: Set up Button - Log out
        screen4UI.logoutButton.addTarget(self, action: #selector(onLogOutButtonTapped), for: .touchUpInside)
        
        // MARK: Set up Button - Delete
        screen4UI.deleteButton.addTarget(self, action: #selector(onDeleteButtonTapped), for: .touchUpInside)
        
        // MARK: Load Account Data
        getUserInfo()
        notificationCenter.addObserver(
            self,
            selector: #selector(getUserInfo),
            name: .accountReloaded,
            object: nil
        )
    }
    
    // MARK: Button Action
    
        // Button - Edit
    @objc func onEditButtonTapped() {
        let screen4EditVC = Screen4_editVC()
        screen4EditVC.receivedAccount = AccountStore.shared.account
        screen4EditVC.receivedImage = AccountStore.shared.photo
        navigationController?.pushViewController(screen4EditVC, animated: true)
    }
    
    @objc func onDeleteButtonTapped() {
        showDeleteAlert()
    }
    
        // Button - Logout
    @objc func onLogOutButtonTapped() {
        // Add alert to confirm logout
        let logoutAlert = UIAlertController(title:"Log out",message: "Are you sure want to log out?", preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out.", style: .default, handler: {(_) in  // If taps "YES" then call firebase
            // Try to sign out safely
            do {
                try Auth.auth().signOut()           // Attempt to sign out the current Firebase user
                // Reset stored account information
                AccountStore.shared.account = nil
                AccountStore.shared.photo = nil
                print("Log out successfully.")
                
            } catch let signOutError as NSError {
                // Catch any error if logout fails
                print("Error signing out: \(signOutError)")
                self.showErrorAlert(title: "Sign Out Error", message: signOutError.localizedDescription)
            }
        } ) )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))   // If taps "NO" then do nothing
        self.present(logoutAlert, animated: true, completion: {() in            // To hide alert it the user taps outside of it:
        logoutAlert.view.superview?.isUserInteractionEnabled = true
        logoutAlert.view.superview?.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(self.onTapOutsideAlert)) ) })
    }
    
    // --- HIDE ALERTS --- //
    @objc func onTapOutsideAlert(){  self.dismiss(animated: true)   }
    
    // MARK: - Get User Info
    @objc func getUserInfo() {
        // Retrieve account information from the store class
        if let account = AccountStore.shared.account {
            screen4UI.nameLabel.text = account.name
            screen4UI.emailLabel.text = account.email
            screen4UI.phoneLabel.text = account.phone
            if let image = AccountStore.shared.photo {
                screen4UI.profileImage.loadImage(image: image)
            } else {
                print("Profile image is not set.")
            }
        } else {
            print("Was not able to fetch user account information.")
        }
    }
    
    
    // MARK: - UI Helper
    func showErrorAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                    style: .default))
        self.present(alertController, animated: true)
    }
    
    // MARK: - UI Helper
    func showDeleteAlert() {
        let alertController = UIAlertController(title: "Delete Account", message: "Are you sure you want to delete the account?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .destructive) { _ in
            self.showActivityIndicator()
            AccountManager().deleteAccount() {[weak self] results in
                DispatchQueue.main.async {
                    self?.hideActivityIndicator()
                }
            }
            AccountStore.shared.account = nil
        }
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
}
