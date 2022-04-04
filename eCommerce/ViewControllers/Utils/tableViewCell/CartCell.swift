//
//  CartCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 21/02/22.
//

import UIKit

class CartCell: UITableViewCell {
    
    static let identifier = "CartCell"
 
    
    var removefromCartBtnAction:((_ product:Product)->())?
    
    var data:Product? {
        didSet{
            guard let product = data else {return}
            self.ProductImage.image = UIImage(named: "\(product.images ?? "default")")
            self.productName.text = product.title
            self.productPrice.text = "$\(product.price)"
            self.offerDetails.text = "\(product.offer)% off"
            self.stepper.currentValue = Int(product.quantitiesSelected)
            let offer:Double = Double(product.price) * (Double(product.offer) / 100.00)
            self.offerPrice.text = "$\(String(format:"%.2f", (product.price - offer)))"
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

    
    private var stepper:Stepper = {
        let stepper = Stepper(frame: CGRect.zero )
        stepper.clipsToBounds = true
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
 
    
    private var productName :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Natural Red Apple"
        txt.font = UIFont.boldSystemFont(ofSize: 15)
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
    
    
    private var offerPrice :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "$4.99"
        txt.font = UIFont.boldSystemFont(ofSize: 20)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    private var offerDetails:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "30% off"
        txt.textColor = .systemRed
        txt.font = UIFont.boldSystemFont(ofSize: 13)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    var productPrice :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        let attribute: NSMutableAttributedString =  NSMutableAttributedString(string:"$2.99")
        attribute.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attribute.length))
        txt.attributedText = attribute
        txt.font = UIFont.systemFont(ofSize: 15)
        txt.textColor = .systemGray
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(ProductImage)
        contentView.addSubview(productName)
        contentView.addSubview(quantityDetails)
        contentView.addSubview(productPrice)
        contentView.addSubview(offerPrice)
        contentView.addSubview(offerDetails)
        contentView.addSubview(stepper)
        stepper.delegate = self
        setupLayout()
    }
    
 
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
            
            ProductImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            ProductImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            ProductImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            ProductImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            productName.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            productName.leadingAnchor.constraint(equalTo: ProductImage.trailingAnchor,constant: 10),
            
            offerDetails.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            offerDetails.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -22),
            
            quantityDetails.topAnchor.constraint(equalTo: productName.bottomAnchor,constant: 5),
            quantityDetails.leadingAnchor.constraint(equalTo: ProductImage.trailingAnchor,constant: 10),
            
            stepper.topAnchor.constraint(equalTo: quantityDetails.bottomAnchor,constant: 7),
            stepper.leadingAnchor.constraint(equalTo: ProductImage.trailingAnchor,constant: 10),
            stepper.widthAnchor.constraint(equalToConstant: 100),
            stepper.heightAnchor.constraint(equalToConstant: 30),
            
            productPrice.topAnchor.constraint(equalTo: quantityDetails.bottomAnchor,constant: 13),
            productPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -22),
            
            offerPrice.topAnchor.constraint(equalTo: quantityDetails.bottomAnchor,constant: 8),
            offerPrice.trailingAnchor.constraint(equalTo: productPrice.leadingAnchor,constant: -8),
    
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


extension CartCell:StepperDelegate {
    func stepperChanged(value: Int) {
        guard let product = data else {return}
        if value == 0 {
            ShopActions.removeFromCart(product: product)
            stepper.currentValue = 1
            return
        }
        ShopActions.StepperValuechanged(with:value,on:product)
    }
}


