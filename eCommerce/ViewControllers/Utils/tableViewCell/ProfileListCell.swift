//
//  ProfileListCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 02/03/22.
//

import UIKit

class ProfileListCell: UITableViewCell {

    static let identifier = "ProfileListCell"
    
    var data:Utils.UserOptionList? {
        didSet{
            guard let list = data else {return}
            self.listTitle.text = list.title
            self.ListImage.image = UIImage(systemName: list.icon)
        }
    }

    
    private var ListImage :UIImageView = {
        let image = UIImageView(frame: CGRect.zero)
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "default")
        image.clipsToBounds = true
        image.tintColor = .systemGreen
//        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    
    private var listTitle :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "XxxxxxxxX"
        txt.font = UIFont.systemFont(ofSize: 16)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(ListImage)
        contentView.addSubview(listTitle)
        setupLayout()
    }
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
        
            ListImage.widthAnchor.constraint(equalToConstant: 30),
            ListImage.heightAnchor.constraint(equalToConstant: 30),
            ListImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            ListImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            listTitle.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            listTitle.leadingAnchor.constraint(equalTo: ListImage.trailingAnchor,constant: 10),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
