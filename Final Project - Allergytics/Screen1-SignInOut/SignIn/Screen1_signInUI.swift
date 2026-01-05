//
//  Screen1_signInUI.swift
//  Final Project - Allergytics
//
//  Created by Yuna Watanabe on 11/4/25.
//

import UIKit

class Screen1_signInUI: UIView {
    var scrollView: UIScrollView!
    var helloTitle: UILabel!
    var welcomeTitle: UILabel!
    var appNameTitle: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var signUpLabel: UILabel!
    var signUpButton: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupScrollView()
        setupHelloTitle()
        setupWelcomeTitle()
        setupAppNameTitle()
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupSignUpLabel()
        setupSignUpButton()
        
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
    
    func setupHelloTitle() {
        helloTitle = UILabel()
        helloTitle.text = "Hello,"
        helloTitle.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        helloTitle.textAlignment = .left
        helloTitle.textColor = Colors().brown
        helloTitle.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(helloTitle)
    }
    
    func setupWelcomeTitle() {
        welcomeTitle = UILabel()
        welcomeTitle.text = "welcome to"
        welcomeTitle.font = UIFont.systemFont(ofSize: 25)
        welcomeTitle.textAlignment = .left
        welcomeTitle.textColor = Colors().brown
        welcomeTitle.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(welcomeTitle)
    }
    
    func setupAppNameTitle() {
        appNameTitle = UILabel()
        appNameTitle.text = "Allergytics"
        appNameTitle.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        appNameTitle.textAlignment = .right
        appNameTitle.textColor = Colors().olive
        appNameTitle.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(appNameTitle)
    }
    
    func setupEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocapitalizationType = .none
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(emailTextField)
    }
    
    func setupPasswordTextField() {
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(passwordTextField)
    }
    
    func setupLoginButton() {
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Log in", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        loginButton.backgroundColor = Colors().olive
        loginButton.layer.cornerRadius = 8
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(loginButton)
    }
    
    func setupSignUpLabel() {
        signUpLabel = UILabel()
        signUpLabel.text = "Don't have an account?"
        signUpLabel.textAlignment = .center
        signUpLabel.textColor = Colors().brown
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(signUpLabel)
    }
    
    func setupSignUpButton() {
        signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        signUpButton.backgroundColor = Colors().olive
        signUpButton.layer.cornerRadius = 8
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(signUpButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            
            helloTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 32),
            helloTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            
            welcomeTitle.topAnchor.constraint(equalTo: helloTitle.bottomAnchor, constant: 16),
            welcomeTitle.leadingAnchor.constraint(equalTo: helloTitle.leadingAnchor),
            
            appNameTitle.topAnchor.constraint(equalTo: welcomeTitle.bottomAnchor, constant: 8),
            appNameTitle.leadingAnchor.constraint(equalTo: helloTitle.leadingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: appNameTitle.bottomAnchor, constant: 64),
            emailTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            emailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            passwordTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 64),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            signUpLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 64),
            signUpLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 32),
            signUpButton.widthAnchor.constraint(equalToConstant: 200),
            signUpButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }

}
