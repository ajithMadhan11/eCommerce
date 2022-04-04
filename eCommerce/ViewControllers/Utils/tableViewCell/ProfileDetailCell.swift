//
//  ProfileDetailCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 03/04/22.
//

import Foundation
import UIKit

class ProfileDetailCell:UITableViewCell {

    
    static let identifier = "ProfileDetailCell"
    
    var icon:UIImageView = {
        let icon = UIImageView(frame: CGRect.zero)
        icon.image = UIImage(systemName: "star")
        icon.tintColor = .black
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    var title:UILabel = {
        let title = UILabel(frame: CGRect.zero)
        title.text = "Address"
        title.font = UIFont.systemFont(ofSize: 14)
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(icon)
        contentView.addSubview(title)
        setupLayout()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            icon.heightAnchor.constraint(equalToConstant: 20),
            icon.widthAnchor.constraint(equalToConstant: 20),
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
//            title.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor,constant: 15),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -15),
            
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
