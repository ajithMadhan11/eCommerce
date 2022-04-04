//
//  ProductCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 22/02/22.
//

import UIKit

class ProductCell: UITableViewCell {

    static let identifier = "ProductCell"
    
    var index:IndexPath?
    
    var data:Product? {
        didSet{
            guard let product = data else {return}
            self.productName.text = product.title
            self.ProductImage.image = UIImage(named: "\(product.images ?? "default")")
            self.productPrice.text = "$\(product.price)"
            let totalReview = Utils.calculateReview(product: product)
            self.starRating.text = "\(String(format:"%.1f",totalReview.0))"
            self.stepper.currentValue = Int(product.quantitiesSelected)
            self.totalRatings.text = "\(totalReview.1) reviews"
            self.offerDetails.text = " \(product.offer)% off"
            let offer:Double = Double(product.price) * (Double(product.offer) / 100.00)
            self.offerPrice.text = "$\(String(format:"%.2f", product.price - offer))"
        }
    }
    
    
     var ProductImage :UIImageView = {
        let image = UIImageView(frame: CGRect.zero)
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "default")
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var stepper:Stepper = {
        let stepper = Stepper(frame: CGRect.zero )
        stepper.clipsToBounds = true
        stepper.isHidden = true
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
        
    lazy var addToCartBtn:UIButton = {
        let btn = UIButton(type: .custom)
        var config = UIButton.Configuration.plain()
        config.background.backgroundColor = .systemBackground
        config.baseForegroundColor = .systemRed
        config.title = "Add"
        config.background.strokeColor = .systemGray
        btn.configuration = config
        btn.addTarget(self, action: #selector(addToCartBtnTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func addToCartBtnTapped(){
        guard let product = data else{return}
        ShopActions.addToCart(product: product)
        addToCartBtn.isHidden = true
        stepper.isHidden = false
        ShopActions.reloadCartCell(cell: self)
    }
    
    var totalRatings :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "234 ratings"
        txt.font = UIFont.boldSystemFont(ofSize: 12)
        txt.textColor = .systemGray3
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
    
    var starRating :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "4.3"
        txt.font = UIFont.boldSystemFont(ofSize: 12)
        txt.textColor = .systemPink
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let starRatingImage :UIImageView = {
        let img = UIImageView(frame: CGRect.zero)
        img.image = UIImage(systemName: "star.fill")
        img.contentMode = .scaleAspectFit
        img.tintColor = .systemPink
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
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
    
    private var offerDetails:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "30% off"
        txt.textColor = .white
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        txt.backgroundColor = .systemPink
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    private var offerPrice :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "$1.99"
        txt.font = UIFont.boldSystemFont(ofSize: 16)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(ProductImage)
        contentView.addSubview(addToCartBtn)
        contentView.addSubview(productName)
        contentView.addSubview(quantityDetails)
        contentView.addSubview(productPrice)
        contentView.addSubview(starRating)
        contentView.addSubview(starRatingImage)
        contentView.addSubview(totalRatings)
        contentView.addSubview(offerPrice)
        contentView.addSubview(offerDetails)
        contentView.addSubview(stepper)
        stepper.delegate = self
        setupLayout()
    }
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
        
            ProductImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ProductImage.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.3),
            ProductImage.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.8),
            ProductImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            
            productName.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            productName.leadingAnchor.constraint(equalTo: ProductImage.trailingAnchor,constant: 5),
            
            offerDetails.bottomAnchor.constraint(equalTo: ProductImage.bottomAnchor),
            offerDetails.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            
            quantityDetails.topAnchor.constraint(equalTo: productName.bottomAnchor,constant: 5),
            quantityDetails.leadingAnchor.constraint(equalTo: ProductImage.trailingAnchor,constant: 5),
            
            starRating.topAnchor.constraint(equalTo: quantityDetails.bottomAnchor,constant: 8),
            starRating.leadingAnchor.constraint(equalTo: ProductImage.trailingAnchor,constant:5),
            
            starRatingImage.heightAnchor.constraint(equalToConstant: 14),
            starRatingImage.widthAnchor.constraint(equalToConstant: 14),
            starRatingImage.topAnchor.constraint(equalTo: quantityDetails.bottomAnchor,constant: 8),
            starRatingImage.leadingAnchor.constraint(equalTo: starRating.trailingAnchor,constant: 5),
            
            totalRatings.topAnchor.constraint(equalTo: quantityDetails.bottomAnchor,constant: 8),
            totalRatings.leadingAnchor.constraint(equalTo: starRatingImage.trailingAnchor,constant: 5),
            
            offerPrice.topAnchor.constraint(equalTo: starRating.bottomAnchor,constant: 8),
            offerPrice.leadingAnchor.constraint(equalTo: ProductImage.trailingAnchor,constant: 5),
            
            productPrice.topAnchor.constraint(equalTo: starRating.bottomAnchor,constant: 10),
            productPrice.leadingAnchor.constraint(equalTo: offerPrice.trailingAnchor,constant: 5),
            
            addToCartBtn.topAnchor.constraint(equalTo: starRating.bottomAnchor,constant: -5),
            addToCartBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -15),
            
            stepper.topAnchor.constraint(equalTo: starRating.bottomAnchor,constant: -5),
            stepper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -15),
            stepper.widthAnchor.constraint(equalToConstant: 100),
            stepper.heightAnchor.constraint(equalToConstant: 30),
        ])
        
    }
    
    override func prepareForReuse() {
        self.ProductImage.image = nil
        self.addToCartBtn.isHidden = false
        self.stepper.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductCell:StepperDelegate {
    func stepperChanged(value: Int) {
        guard let product = data else {return}
        if value == 0 {
            ShopActions.removeFromCart(product: product)
            self.addToCartBtn.isHidden = false
            self.stepper.isHidden = true
            self.stepper.currentValue = 1
            return
        }
        ShopActions.StepperValuechanged(with:value,on:product)
    }
}
