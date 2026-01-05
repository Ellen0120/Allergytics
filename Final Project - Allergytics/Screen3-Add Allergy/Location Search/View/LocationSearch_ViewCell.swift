//
//  LocationSearch_TableViewCell.swift
//  Final Project - Allergytics
//
//  Created by 明倫 on 2025/11/15.
//

import UIKit

class LocationSearch_ViewCell: UITableViewCell {

    // MARK: -UI Componenets
    var wrapperCellView: UIView!
    var labelTitle: UILabel!
    var labelSubtitle: UILabel!
    
    // MARK: -Setup elements and constraints
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellVIew()
        setupLabelTitle()
        setupLabelSubtitle()
        initConstraints()
    }

    // MARK: - UI Method Setup
        // Wrapper Cell View
    func setupWrapperCellVIew() {
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
        // Label - Title
    func setupLabelTitle() {
        labelTitle = UILabel()
        labelTitle.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        labelTitle.textColor = .label
        labelTitle.numberOfLines = 1
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTitle)
    }
    
        // Label - SubTitle
    func setupLabelSubtitle() {
        labelSubtitle = UILabel()
        labelSubtitle.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        labelSubtitle.textColor = .secondaryLabel
        labelSubtitle.numberOfLines = 1
        labelSubtitle.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelSubtitle)
    }
        // Constraints
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 4),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelTitle.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 4),
            labelTitle.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            labelTitle.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -10),
            labelTitle.heightAnchor.constraint(equalToConstant: 20),
            
            labelSubtitle.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 2),
            labelSubtitle.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            labelSubtitle.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -10),
            labelSubtitle.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -4),
        ])
    }
    
    
    // Called when the cell’s selection state changes (gray background)
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /* Not used: we don't load this cell from Storyboard/XIB */
    
    // Called after the cell is loaded from a Storyboard/XIB
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Required for Storyboard/XIB, not used here (programmatic only)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
