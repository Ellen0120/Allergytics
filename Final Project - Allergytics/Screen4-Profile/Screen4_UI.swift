//
//  Screen4_UI.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/10/29.
//

import UIKit

class Screen4_UI: UIView {
    var scrollView: UIScrollView!
    var profileTitle: UILabel!
    var profileImage: UIImageView!
    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var phoneLabel: UILabel!
    var logoutButton: UIButton!
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
        
        // set up elements
        setupScrollView()
        setupProfileTitle()
        setupProfileIcon()
        setupNameLabel()
        setupEmailLabel()
        setupPhoneLabel()
        setupLogoutButton()
        setupDeleteButton()
        
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
    
    func setupProfileTitle() {
        profileTitle = UILabel()
        profileTitle.text = "Profile information"
        profileTitle.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        profileTitle.textColor = Colors().olive
        profileTitle.textAlignment = .center
        profileTitle.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(profileTitle)
    }
    
    func setupProfileIcon() {
        profileImage = UIImageView()
        profileImage.image = UIImage(systemName: "person.crop.circle")
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 8
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        
        let config = UIImage.SymbolConfiguration(paletteColors: [
            Colors().olive
        ])
        profileImage.preferredSymbolConfiguration = config
        
        scrollView.addSubview(profileImage)
    }
    
    func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.text = ""
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        nameLabel.textColor = Colors().brown
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(nameLabel)
    }
    
    func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.text = ""
        emailLabel.textAlignment = .center
        emailLabel.textColor = Colors().brown
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(emailLabel)
    }
    
    func setupPhoneLabel() {
        phoneLabel = UILabel()
        phoneLabel.text = ""
        phoneLabel.textAlignment = .center
        phoneLabel.textColor = Colors().brown
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(phoneLabel)
    }
    
    func setupLogoutButton() {
        logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.backgroundColor = Colors().olive
        logoutButton.layer.cornerRadius = 8
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(logoutButton)
    }
    
    func setupDeleteButton() {
        deleteButton = UIButton(type: .system)
        deleteButton.setTitle("Delete Account", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(deleteButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            
            profileTitle.topAnchor.constraint(equalTo: scrollView.topAnchor),
            profileTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            profileImage.topAnchor.constraint(equalTo: profileTitle.bottomAnchor, constant: 16),
            profileImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 150),
            profileImage.widthAnchor.constraint(equalToConstant: 150),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32),
            emailLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16),
            phoneLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            logoutButton.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 64),
            logoutButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 200),
            
            deleteButton.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 64),
            deleteButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}
