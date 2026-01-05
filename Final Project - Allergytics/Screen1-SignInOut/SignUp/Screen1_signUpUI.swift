//
//  Screen1_signUpUI.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 11/5/25.
//

import UIKit

class Screen1_signUpUI: UIView {
    var scrollView: UIScrollView!
    var signUpTitle: UILabel!
    var profileImageButton: UIButton!
    var editSign: UILabel!
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var phoneTextField: UITextField!
    var passwordTextField: UITextField!
    var createButton: UIButton!
    var deleteButton: UIButton!
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
        setupSignUpTitle()
        setupProfileImageButton()
        setupEditSign()
        setupNameTextField()
        setupEmailTextField()
        setupPhoneTextField()
        setupPasswordTextField()
        setupCreateButton()
        
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
    
    func setupSignUpTitle() {
        signUpTitle = UILabel()
        signUpTitle.text = "Create New Account"
        signUpTitle.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        signUpTitle.textColor = Colors().olive
        signUpTitle.textAlignment = .center
        signUpTitle.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(signUpTitle)
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
    
    func setupPasswordTextField() {
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(passwordTextField)
    }
    
    func setupCreateButton() {
        createButton = UIButton(type: .system)
        createButton.setTitle("Create Account", for: .normal)
        createButton.setTitleColor(.white, for: .normal)
        createButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        createButton.backgroundColor = Colors().olive
        createButton.layer.cornerRadius = 8
        createButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(createButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor),
            
            signUpTitle.topAnchor.constraint(equalTo: scrollView.topAnchor),
            signUpTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            profileImageButton.topAnchor.constraint(equalTo: signUpTitle.bottomAnchor, constant: 10),
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
            phoneTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 16),
            passwordTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            passwordTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            createButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 64),
            createButton.widthAnchor.constraint(equalToConstant: 200),
            createButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            createButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
}
