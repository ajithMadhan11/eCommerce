//
//  SearchResultCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 21/03/22.
//

import Foundation
import UIKit

class SearchResultCell: UITableViewCell {

    static let identifier = "SearchResultCell"
    
    var data:Product? {
        didSet{
            guard let product = data else {return}
            self.ProductImage.image = UIImage(named: "\(product.images ?? "default")")
            self.productName.text = product.title
        }
    }
    
    
    private var ProductImage :UIImageView = {
        let image = UIImageView(frame: CGRect.zero)
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "default")
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    
    private var productName :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Natural Red Apple"
        txt.font = UIFont.boldSystemFont(ofSize: 18)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(ProductImage)
        contentView.addSubview(productName)
        setupLayout()
    }
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
        
            ProductImage.widthAnchor.constraint(equalToConstant: 40),
            ProductImage.heightAnchor.constraint(equalToConstant: 40),
            ProductImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            ProductImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            productName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productName.leadingAnchor.constraint(equalTo: ProductImage.trailingAnchor,constant: 10),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
