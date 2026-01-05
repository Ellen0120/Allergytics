//
//  Screen4_editUI.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 11/4/25.
//

import UIKit

class Screen4_editUI: UIView {
    var scrollView: UIScrollView!
    var editTitle: UILabel!
    var profileImageButton: UIButton!
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var phoneTextField: UITextField!
    var saveButton: UIButton!
    var deleteButton: UIButton!
    var editSign: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // set up
        setupScrollView()
        setupEditTitle()
        setupProfileImageButton()
        setupNameTextField()
        setupEmailTextField()
        setupPhoneTextField()
        setupSaveButton()
        setupDeleteButton()
        setupEditSign()
        
        // set constraints
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }
    
    func setupEditTitle() {
        editTitle = UILabel()
        editTitle.text = "Edit Profile"
        editTitle.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        editTitle.textColor = Colors().olive
        editTitle.textAlignment = .center
        editTitle.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(editTitle)
    }
    
    func setupProfileImageButton() {
        profileImageButton = UIButton(type: .system)
        profileImageButton.setImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        profileImageButton.contentHorizontalAlignment = .fill
        profileImageButton.contentVerticalAlignment = .fill
        profileImageButton.imageView?.contentMode = .scaleAspectFill
        profileImageButton.imageView?.clipsToBounds = true
        profileImageButton.imageView?.layer.cornerRadius = 8
        profileImageButton.tintColor = Colors().olive
        profileImageButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(profileImageButton)
    }
    
    func setupNameTextField() {
        nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(nameTextField)
    }
    
    func setupEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocapitalizationType = .none
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(emailTextField)
    }
    
    func setupPhoneTextField() {
        phoneTextField = UITextField()
        phoneTextField.placeholder = "Phone number"
        phoneTextField.keyboardType = .numberPad
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(phoneTextField)
    }
    
    func setupSaveButton() {
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        saveButton.backgroundColor = Colors().olive
        saveButton.layer.cornerRadius = 8
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(saveButton)
    }
    
    func setupDeleteButton() {
        deleteButton = UIButton(type: .system)
        deleteButton.setTitle("Delete Account", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(deleteButton)
    }
    
    func setupEditSign() {
        editSign = UILabel()
        editSign.text = "Tap To Change!"
        editSign.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        editSign.backgroundColor = Colors().offwhite
        editSign.textColor = Colors().olive
        editSign.textAlignment = .center
        editSign.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(editSign)

    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor),
            
            editTitle.topAnchor.constraint(equalTo: scrollView.topAnchor),
            editTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            profileImageButton.topAnchor.constraint(equalTo: editTitle.bottomAnchor, constant: 40),
            profileImageButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            profileImageButton.widthAnchor.constraint(equalToConstant: 150),
            profileImageButton.heightAnchor.constraint(equalToConstant: 150),
            
            editSign.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            editSign.topAnchor.constraint(equalTo: profileImageButton.bottomAnchor, constant: 20),
            
            nameTextField.topAnchor.constraint(equalTo: editSign.bottomAnchor, constant: 32),
            nameTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            nameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            emailTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            emailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            phoneTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            phoneTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            phoneTextField.centerXAnchor.constraint(equalTo: nameTextField.centerXAnchor),
            
            saveButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 64),
            saveButton.widthAnchor.constraint(equalToConstant: 200),
            saveButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            deleteButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 64),
            deleteButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
}
