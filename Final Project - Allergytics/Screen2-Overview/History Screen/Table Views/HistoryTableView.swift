//
//  HistoryTableView.swift
//  Final Project - Allergytics
//
//  Created by Arive Maynes on 11/11/25.
//

import UIKit

class HistoryTableView: UITableViewCell {

    // --- Set the elements for hte table vew --- //
    var wrapperCellView: UIView!
    var labelTrigger: UILabel!
    var labelSymptoms: UILabel!
    var labelLocation: UILabel!
    var labelDate: UILabel!
    
    // --- Initialize elements and constraints --- //
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Colors().offwhite
        setupWrapperCellView()
        setupLabelTrigger()
        setupLabelSymptoms()
        setupLabelLocation()
        setupLabelDate()
        initConstraints()
    }
    
    // --- Element functions --- //
    func setupWrapperCellView(){
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = Colors().palegreen
        wrapperCellView.layer.cornerRadius = 4.0
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    func setupLabelTrigger(){
        labelTrigger = UILabel()
        labelTrigger.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        labelTrigger.numberOfLines = 0
        labelTrigger.lineBreakMode = .byWordWrapping
        labelTrigger.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTrigger)
    }
    
    func setupLabelSymptoms(){
        labelSymptoms = UILabel()
        labelSymptoms.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        labelSymptoms.numberOfLines = 0
        labelSymptoms.lineBreakMode = .byWordWrapping
        labelSymptoms.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelSymptoms)
    }
    
    func setupLabelLocation(){
        labelLocation = UILabel()
        labelLocation.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        labelLocation.numberOfLines = 0
        labelLocation.lineBreakMode = .byWordWrapping
        labelLocation.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelLocation)
    }
    
    func setupLabelDate(){
        labelDate = UILabel()
        labelDate.font = UIFont.systemFont(ofSize: 13)
        labelDate.numberOfLines = 0
        labelDate.textColor = UIColor.gray
        labelDate.lineBreakMode = .byWordWrapping
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDate)
    }
    
    // --- Initialize constraints --- //
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 4),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),

            labelDate.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 10),
            labelDate.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            
            labelLocation.topAnchor.constraint(equalTo: labelDate.bottomAnchor, constant: 5),
            labelLocation.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            labelLocation.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -15),
            
            
            labelTrigger.topAnchor.constraint(equalTo: labelLocation.bottomAnchor, constant: 5),
            labelTrigger.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            labelTrigger.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -15),
            
            labelSymptoms.topAnchor.constraint(equalTo: labelTrigger.bottomAnchor, constant: 5),
            labelSymptoms.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -10),
            labelSymptoms.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            labelSymptoms.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -15)
            
            
            
            
        ])
    }
    
    override func awakeFromNib() {  super.awakeFromNib()  }                // Initialization code
    override func setSelected(_ selected: Bool, animated: Bool) {super.setSelected(selected, animated: animated)}
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    

}
