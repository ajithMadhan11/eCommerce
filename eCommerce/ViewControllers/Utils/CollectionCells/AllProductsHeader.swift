//
//  AllProductsHeader.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 22/02/22.
//

import UIKit

class AllProductsHeader: UITableViewHeaderFooterView {
    
    static let identifier = "AllProductsHeader"
    
    
    let title:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Showing products tagged with "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleHigh:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Category"
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
        contentView.addSubview(titleHigh)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func setupLayout() {
   
        NSLayoutConstraint.activate([
            
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),

            titleHigh.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleHigh.leadingAnchor.constraint(equalTo: title.trailingAnchor,constant: 4)
            
        ])
        
    }
}
