//
//  LegendView.swift
//  Final Project - Allergytics
//
//  Created by Arive Maynes on 12/6/25.
//

import UIKit

class LegendView: UIView {
    
    // --- Define elements --- //
    var infoLabel = UILabel()
    var highLabel = UILabel()
    var highIcon = UIImageView()
    var mediumLabel = UILabel()
    var mediumIcon = UIImageView()
    var lowLabel = UILabel()
    var lowIcon = UIImageView()

    // --- Setup elements and constraints --- //
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white.withAlphaComponent(0.8)
        layer.cornerRadius = 8
        clipsToBounds = true
        setupLegendLabel()
        setupHighLabel()
        setupHighIcon()
        setupMediumLabel()
        setupMediumIcon()
        setupLowLabel()
        setupLowIcon()
        initConstraints()
    }

    // --- Setup Functions --- //
    func setupLegendLabel(){
        infoLabel = UILabel()
        infoLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        infoLabel.text = "Severity"
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(infoLabel)
    }
    func setupHighLabel(){
        highLabel = UILabel()
        highLabel.font = UIFont.systemFont(ofSize: 12)
        highLabel.text = "High"
        highLabel.numberOfLines = 0
        highLabel.lineBreakMode = .byWordWrapping
        highLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(highLabel)
    }
    func setupHighIcon() {
        highIcon = UIImageView()
        highIcon.image = UIImage(systemName: "circle.fill")
        highIcon.tintColor = .systemRed
        highIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(highIcon)
    }
    func setupMediumLabel(){
        mediumLabel = UILabel()
        mediumLabel.font = UIFont.systemFont(ofSize: 12)
        mediumLabel.text = "Medium"
        mediumLabel.numberOfLines = 0
        mediumLabel.lineBreakMode = .byWordWrapping
        mediumLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mediumLabel)
    }
    func setupMediumIcon() {
        mediumIcon = UIImageView()
        mediumIcon.image = UIImage(systemName: "circle.fill")
        mediumIcon.tintColor = .systemOrange
        mediumIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mediumIcon)
    }
    func setupLowLabel(){
        lowLabel = UILabel()
        lowLabel.font = UIFont.systemFont(ofSize: 12)
        lowLabel.text = "Low"
        lowLabel.numberOfLines = 0
        lowLabel.lineBreakMode = .byWordWrapping
        lowLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lowLabel)
    }
    func setupLowIcon() {
        lowIcon = UIImageView()
        lowIcon.image = UIImage(systemName: "circle.fill")
        lowIcon.tintColor = .systemGreen
        lowIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lowIcon)
    }
    
    // --- Constratins --- //
    func initConstraints(){
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            infoLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),

            highLabel.centerYAnchor.constraint(equalTo: highIcon.centerYAnchor),
            highLabel.leadingAnchor.constraint(equalTo: highIcon.trailingAnchor, constant: 10),
            
            highIcon.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 8),
            highIcon.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            highIcon.heightAnchor.constraint(equalToConstant: 12),
            highIcon.widthAnchor.constraint(equalToConstant: 12),
            
            mediumLabel.centerYAnchor.constraint(equalTo: mediumIcon.centerYAnchor),
            mediumLabel.leadingAnchor.constraint(equalTo: mediumIcon.trailingAnchor, constant: 10),
            
            mediumIcon.topAnchor.constraint(equalTo: highIcon.bottomAnchor, constant: 8),
            mediumIcon.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mediumIcon.heightAnchor.constraint(equalToConstant: 12),
            mediumIcon.widthAnchor.constraint(equalToConstant: 12),
            
            lowLabel.centerYAnchor.constraint(equalTo: lowIcon.centerYAnchor),
            lowLabel.leadingAnchor.constraint(equalTo: lowIcon.trailingAnchor, constant: 10),
            
            lowIcon.topAnchor.constraint(equalTo: mediumIcon.bottomAnchor, constant: 8),
            lowIcon.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            lowIcon.heightAnchor.constraint(equalToConstant: 12),
            lowIcon.widthAnchor.constraint(equalToConstant: 12),
            
            
        ])
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
