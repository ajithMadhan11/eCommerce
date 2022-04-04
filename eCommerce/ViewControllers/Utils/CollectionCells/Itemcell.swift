//
//  Itemcell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 18/02/22.
//

import UIKit


class Itemcell: UICollectionViewCell {
    
    static let identifier = "Itemcell"

    var index:IndexPath?
    
    var data:Product? {
        didSet{
            guard let product = data else {return}
            self.productName.text = product.title
            self.ProductImage.image = UIImage(named: "\(product.images ?? "default")")
            self.productPrice.text = "$\(product.price)"
            self.stepper.currentValue = Int(product.quantitiesSelected)
            self.offerDetails.text = "\(product.offer)% off"
            let offer:Double = Double(product.price) * (Double(product.offer) / 100.00)
            self.offerPrice.text = "$\(String(format:"%.2f", product.price - offer))"
        }
    }
    
    public var ProductImage :UIImageView = {
        let image = UIImageView(frame: CGRect.zero)
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "default")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    public var productName :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Apple"
        txt.font = UIFont.boldSystemFont(ofSize: 12)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    public var quantityDetails :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "1kg,Price"
        txt.textColor = .systemGray
        txt.font = UIFont.boldSystemFont(ofSize: 10)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    public var productPrice :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        let attribute: NSMutableAttributedString =  NSMutableAttributedString(string:"$2.99")
        attribute.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attribute.length))
        txt.attributedText = attribute
        txt.font = UIFont.systemFont(ofSize: 9)
        txt.textColor = .systemGray
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    public var offerPrice :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "$4.99"
        txt.font = UIFont.boldSystemFont(ofSize: 13)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    public var offerDetails:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "30% off"
        txt.textColor = .white
        
        txt.backgroundColor = .systemPink
        txt.font = UIFont.boldSystemFont(ofSize: 10)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    public var stepper:Stepper = {
        let stepper = Stepper(frame: CGRect.zero )
        stepper.clipsToBounds = true
        stepper.isHidden = true
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    

    public let addBtn:UIButton = {
        let btn = UIButton(frame: CGRect.zero)
        var config = UIButton.Configuration.plain()
        config.background.strokeColor = .systemRed
        config.background.strokeWidth = 0.4
        config.baseForegroundColor = .systemRed
        btn.configuration = config
        btn.setTitle("Add", for: .normal)
        btn.backgroundColor = .systemBackground
        btn.layer.cornerRadius = 13
        btn.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    @objc func addToCartTapped(){
        guard let product = data else {return}
        ShopActions.addToCart(product: product)
            self.stepper.isHidden = false
            self.addBtn.isHidden = true
        ShopActions.reloadCartCell(cell: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.ProductImage.image = nil
        self.stepper.isHidden = true
//        self.stepper.currentValue = 1
        self.addBtn.isHidden = false
//        addBtn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.backgroundColor = .systemGray6
        contentView.addSubview(ProductImage)
        contentView.addSubview(productName)
        contentView.addSubview(quantityDetails)
        contentView.addSubview(offerPrice)
        contentView.addSubview(productPrice)
        contentView.addSubview(addBtn)
//        addBtn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(offerDetails)
        contentView.addSubview(stepper)
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 0.3
        contentView.layer.borderColor = UIColor.gray.cgColor
        stepper.delegate = self
        contentView.clipsToBounds = true
       
        setupLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        
        NSLayoutConstraint.activate([
            ProductImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            ProductImage.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.45),
            ProductImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            productName.topAnchor.constraint(equalTo: ProductImage.bottomAnchor,constant: 5),
            productName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            
            quantityDetails.topAnchor.constraint(equalTo: productName.bottomAnchor,constant: 5),
            quantityDetails.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            
            productPrice.topAnchor.constraint(equalTo: quantityDetails.bottomAnchor,constant: 8),
            productPrice.leadingAnchor.constraint(equalTo: offerPrice.trailingAnchor,constant: 1),
            
            offerPrice.widthAnchor.constraint(equalToConstant: 40),
            offerPrice.topAnchor.constraint(equalTo: quantityDetails.bottomAnchor,constant: 5),
            offerPrice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            
            offerDetails.bottomAnchor.constraint(equalTo: ProductImage.bottomAnchor),
            offerDetails.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            addBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8),
            addBtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addBtn.widthAnchor.constraint(equalTo:contentView.widthAnchor,multiplier: 0.9),
            addBtn.heightAnchor.constraint(equalToConstant: 26),
            
//            stepper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -3),
            stepper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            stepper.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stepper.widthAnchor.constraint(equalTo:contentView.widthAnchor,multiplier: 0.9),
            stepper.heightAnchor.constraint(equalToConstant: 26),
            
        ])
    }
    
}


extension Itemcell:StepperDelegate {
    func stepperChanged(value: Int) {
        guard let product = data else {return}
        if value == 0 {
            ShopActions.removeFromCart(product: product)
            self.addBtn.isHidden = false
            self.stepper.isHidden = true
            self.stepper.currentValue = 1
            return
        }
        ShopActions.StepperValuechanged(with:value,on:product)
    }
}
