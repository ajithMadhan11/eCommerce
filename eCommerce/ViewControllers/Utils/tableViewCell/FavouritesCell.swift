//
//  FavouritesCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 21/02/22.
//

import UIKit

class FavouritesCell: UITableViewCell {

    static let identifier = "FavouritesCell"
    
    var data:Product? {
        didSet{
            guard let product = data else {return}
            self.ProductImage.image = UIImage(named: "\(product.images ?? "default")")
            self.productName.text = product.title
            self.productPrice.text = "$\(product.price)"
        }
    }
    
    
    private var ProductImage :UIImageView = {
        let image = UIImageView(frame: CGRect.zero)
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "default")
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
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
    
    
    private var quantityDetails :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "1kg,Price"
        txt.textColor = .systemGray
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private var productPrice :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "$4.99"
        txt.font = UIFont.boldSystemFont(ofSize: 16)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(ProductImage)
        contentView.addSubview(productName)
        contentView.addSubview(quantityDetails)
        contentView.addSubview(productPrice)
        setupLayout()
    }
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
        
            ProductImage.widthAnchor.constraint(equalToConstant: 70),
            ProductImage.heightAnchor.constraint(equalToConstant: 70),
            ProductImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            ProductImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            productName.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 30),
            productName.leadingAnchor.constraint(equalTo: ProductImage.trailingAnchor,constant: 10),
            
            quantityDetails.topAnchor.constraint(equalTo: productName.bottomAnchor,constant: 5),
            quantityDetails.leadingAnchor.constraint(equalTo: ProductImage.trailingAnchor,constant: 10),
            
            productPrice.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -18),
            
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
