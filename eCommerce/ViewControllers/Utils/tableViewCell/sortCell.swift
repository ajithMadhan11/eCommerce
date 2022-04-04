//
//  sortCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 24/02/22.
//

import UIKit

class sortCell: UITableViewCell {

    static let identifier = "sortCell"
    
    let title:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Price Low to High "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let icon:UIImageView = {
        let icon = UIImageView(frame: CGRect.zero)
        icon.image = UIImage(systemName: "arrow.up")
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
        contentView.addSubview(icon)
        contentView.backgroundColor = .systemBackground
        setupViews()
    }
    
    override func prepareForReuse() {
        self.accessoryType = .none
    }
    
    private func setupViews(){
        icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20).isActive = true
        
        title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: icon.trailingAnchor,constant: 20).isActive = true
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
