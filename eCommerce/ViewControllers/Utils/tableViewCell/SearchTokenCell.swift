//
//  SearchToken.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 22/03/22.
//

import UIKit

class SearchTokenCell: UITableViewCell {
    
    static let identifier = "SearchTokenCell"
    
    var data:Product? {
        didSet{
            guard let product = data else {
              return
            }
            self.filterName.text = product.title
        }
    }
    var text:RecentText? {
        didSet {
            guard let text = text else {
                return
            }
            self.filterName.text = text.search
        }
    }
    
    private var icon :UIImageView = {
        let image = UIImageView(frame: CGRect.zero)
        image.contentMode = .scaleAspectFill
        let largeBoldBtn = UIImage(systemName: "clock")
        image.image = largeBoldBtn
        image.tintColor = .systemGray
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var filterName :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "filter"
        txt.font = UIFont.boldSystemFont(ofSize: 16)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(icon)
        contentView.addSubview(filterName)
        setupLayout()
    }
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
        
            icon.widthAnchor.constraint(equalToConstant: 25),
            icon.heightAnchor.constraint(equalToConstant: 25),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            filterName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            filterName.leadingAnchor.constraint(equalTo: icon.trailingAnchor,constant: 10),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
