//
//  TableViewPrototypeCellTableViewCell.swift
//  Easy cook
//
//  Created by иван Бирюков on 27.02.2023.
//

import UIKit

class TableViewPrototypeCell: UITableViewCell {
    
    var recieptImageView = UIImageView()
    var recieptTitleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(recieptImageView)
        addSubview(recieptTitleLabel)
        
        configurRecieptImageView()
        configurRecieptNameLabel()
        setImageConstraints()
        setTitleLableConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(recieptList: RecieptListModel) {
        recieptImageView.image = recieptList.image
        recieptTitleLabel.text = recieptList.title
    }
    
    func configurRecieptImageView() {
        recieptImageView.layer.cornerRadius = 10
        recieptImageView.clipsToBounds = true
    }
    
    func configurRecieptNameLabel() {
        recieptTitleLabel.numberOfLines = 0
        recieptTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setImageConstraints() {
        recieptImageView.translatesAutoresizingMaskIntoConstraints = false
        recieptImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        recieptImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        recieptImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        recieptImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setTitleLableConstraints() {
        recieptTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        recieptTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 205).isActive = true
        recieptTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        recieptTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -12).isActive = true
        recieptTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
