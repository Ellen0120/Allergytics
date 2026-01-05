//
//  Screen1_signUpVC.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 11/5/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PhotosUI

class Screen1_signUpVC: UIViewController {
    
    // MARK: - Initialize Main Screen View
    let screen1SignUpUI = Screen1_signUpUI()
    var pickerImage: UIImage?
    
    // MARK: - Data Source
    let db = Firestore.firestore()
    
    // MARK: - Progress Indicator
    let childProgressView = ProgressSpinnerViewController()
    
    // MARK: -LOAD VIEW
    override func loadView() {
        view = screen1SignUpUI
    }
    
    // MARK: -VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors().offwhite
        
        // MARK: Set up Button - Create
        screen1SignUpUI.createButton.addTarget(self,
                                               action: #selector(onCreateButtonTapped),
                                               for: .touchUpInside)
        
        
        // Hide Keyboard
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboardOnTap)
        )
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        
        screen1SignUpUI.profileImageButton.menu = getMenuImagePicker()
        screen1SignUpUI.profileImageButton.showsMenuAsPrimaryAction = true
    }

    // MARK: Button Action
  
    // Button - Create
    @objc func onCreateButtonTapped() {
        
        // Unwrap
        let name = screen1SignUpUI.nameTextField.text ?? ""
        let email = screen1SignUpUI.emailTextField.text ?? ""
        let phone = screen1SignUpUI.phoneTextField.text ?? ""
        let password = screen1SignUpUI.passwordTextField.text ?? ""
        var photo = screen1SignUpUI.profileImageButton.currentImage
        
        let defaultPhoto = UIImage(systemName: "person.crop.circle")
        photo = photo != defaultPhoto ? photo : nil
        
        // Validate Input (Screen1_signUp_Validation: Empty, Email & Phone Format)
        if !validateInputs(name: name,
                           email: email,
                           phone: phone,
                           password: password) {
            return
        }
        
        print("Validates Data Successfully")
        
        // MARK: Create New User in Firebase Auth
        self.showActivityIndicator()
        AccountManager().createAccount(
            name: name,
            email: email,
            password: password,
            phone: phone,
            photo: photo
        ) { [weak self] result in
            // Hide indicator once createAccount is completed
            DispatchQueue.main.async {
                self?.hideActivityIndicator()
            }
        }
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
    
    func getMenuImagePicker() -> UIMenu {
        let menuItems = [
            UIAction(title: "Camera", handler: {(_) in
                self.pickWithCamera()
            }),
            UIAction(title: "Gallery", handler: {(_) in
                self.pickFromGallery()
            })
        ]
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    func pickWithCamera() {
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    func pickFromGallery() {
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }

}
