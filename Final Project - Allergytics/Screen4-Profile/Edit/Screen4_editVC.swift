//
//  Screen4_editVC.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 11/4/25.
//

import UIKit
import PhotosUI

class Screen4_editVC: UIViewController {
    // MARK: UIView
    let screen4EditUI = Screen4_editUI()
    
    // MARK: Profile Image
    var pickerImage: UIImage?
    
    // MARK: Received contact info
    var receivedAccount: UserInfo?
    var receivedImage: UIImage?
    
    // MARK: Progress view controller
    let childProgressView = ProgressSpinnerViewController()
    
    // MARK: LOADVIEW
    override func loadView() {
        view = screen4EditUI
    }

    // MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors().offwhite // off-white
        
        screen4EditUI.profileImageButton.menu = getMenuImagePicker()
        screen4EditUI.profileImageButton.showsMenuAsPrimaryAction = true
        
        // MARK: Set up Button - Delete
        screen4EditUI.deleteButton.addTarget(self, action: #selector(onDeleteButtonTapped), for: .touchUpInside)
        
        screen4EditUI.saveButton.addTarget(self, action: #selector(onSaveButtonTapped), for: .touchUpInside)
        
        reflectAccountInfo()
    }
    
    @objc func onDeleteButtonTapped() {
        showDeleteAlert()
    }
    
    @objc func onSaveButtonTapped() {
        let name = screen4EditUI.nameTextField.text ?? ""
        let email = screen4EditUI.emailTextField.text ?? ""
        let phone = screen4EditUI.phoneTextField.text ?? ""
        
        if !validateInputs(
            name: name,
            email: email,
            phone: phone
        ) {
            return
        }
        
        if var account = receivedAccount {
            Task {
                // MARK: Show activity indicator
                self.showActivityIndicator()
                var oldPhotoURL = account.photoURL
                var url: URL? = nil
                if let pickedImage = pickerImage {
                    url = await AccountManager().uploadProfilePhotoToStorage(image: pickedImage)
                }
                account.name = name
                account.email = email
                account.phone = phone
                account.photoURL = url?.absoluteString ?? oldPhotoURL
                
                // do not delete old photo when user did not upload a new photo
                oldPhotoURL = url == nil ? nil : oldPhotoURL
                
                AccountManager()
                    .editAccount(account: account, oldPhotoURL: oldPhotoURL) { [weak self] result in
                        // MARK: Hide activity indicator once editing account is complete
                        DispatchQueue.main.async {
                            self?.hideActivityIndicator()
                            self?.navigationController?.popViewController(animated: true)
                        }
                    }
            }
        } else {
            print("No account information was received and cannot save the updates.")
        }
    }
    
    // MARK: Get menu for the Image picker
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
    
    // MARK: Pick a photo from camera
    func pickWithCamera() {
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    // MARK: Pick a photo from gallery
    func pickFromGallery() {
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    // MARK: Reflect the received acount information to UI
    func reflectAccountInfo() {
        if let account = receivedAccount {
            screen4EditUI.nameTextField.text = account.name
            screen4EditUI.emailTextField.text = account.email
            screen4EditUI.phoneTextField.text = account.phone
            if let image = receivedImage {
                screen4EditUI.profileImageButton.setImage(
                    image.withRenderingMode(.alwaysOriginal),
                    for: .normal
                )
            }
        } else {
            print("No account information found!")
        }
    }
    
    // MARK: - UI Helper
    func showDeleteAlert() {
        let alertController = UIAlertController(title: "Delete Account", message: "Are you sure you want to delete the account?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .destructive) { _ in
            self.showActivityIndicator()
            AccountManager().deleteAccount() {[weak self] result in
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
