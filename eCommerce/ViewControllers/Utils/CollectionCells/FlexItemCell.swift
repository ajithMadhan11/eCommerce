//
//  FlexItemCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 10/03/22.
//

import UIKit

class FlexItemCell: UICollectionViewCell {
    static let identifier = "FlexItemCell"

    var index:IndexPath?
    var data:Product? {
        didSet{
            guard let product = data else {return}
            self.productName.text = product.title
            self.ProductImage.image = UIImage(named: "\(product.images ?? "default")")
            self.productPrice.text = "$\(product.price)"
            self.offerDetails.text = " \(product.offer)% off"
            self.stepper.currentValue = Int(product.quantitiesSelected)
            let offer:Double = Double(product.price) * (Double(product.offer) / 100.00)
            self.offerPrice.text = "$\(String(format:"%.2f", product.price - offer))"
        }
    }
    
     var ProductImage :UIImageView = {
        let image = UIImageView(frame: CGRect.zero)
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "default")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var productName :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Apple"
        txt.font = UIFont.boldSystemFont(ofSize: 16)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private var offerPrice :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "$4.99"
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private var offerDetails:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "30% off"
        txt.textColor = .white
        txt.backgroundColor = .systemPink
        txt.font = UIFont.boldSystemFont(ofSize: 12)
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
    
   private var productPrice :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        let attribute: NSMutableAttributedString =  NSMutableAttributedString(string:"$2.99")
        attribute.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attribute.length))
        txt.attributedText = attribute
        txt.font = UIFont.systemFont(ofSize: 9)
        txt.textColor = .systemGray
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
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
//        addBtn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        self.addBtn.isHidden = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(ProductImage)
        contentView.addSubview(productName)
        contentView.addSubview(productPrice)
        contentView.addSubview(offerPrice)
        contentView.addSubview(offerDetails)
        contentView.addSubview(addBtn)
//        addBtn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(stepper)
        stepper.delegate = self
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 0.4
        contentView.layer.borderColor = UIColor.gray.cgColor
        setupLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        
        NSLayoutConstraint.activate([
            ProductImage.widthAnchor.constraint(equalTo:contentView.widthAnchor,multiplier: 0.30),
            ProductImage.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            ProductImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            productName.leadingAnchor.constraint(equalTo: ProductImage.trailingAnchor,constant: 10),
            productName.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            productName.trailingAnchor.constraint(equalTo: addBtn.leadingAnchor,constant: -2),
            
            offerPrice.leadingAnchor.constraint(equalTo: ProductImage.trailingAnchor,constant: 10),
            offerPrice.topAnchor.constraint(equalTo: productName.bottomAnchor,constant: 5),
            
            productPrice.leadingAnchor.constraint(equalTo: offerPrice.trailingAnchor,constant: 5),
            productPrice.topAnchor.constraint(equalTo: productName.bottomAnchor,constant: 10),
            
            offerDetails.bottomAnchor.constraint(equalTo: ProductImage.bottomAnchor),
            offerDetails.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            addBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            addBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            addBtn.widthAnchor.constraint(equalToConstant: 80),
            addBtn.heightAnchor.constraint(equalToConstant: 25),
            
            stepper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            stepper.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stepper.widthAnchor.constraint(equalToConstant: 100),
            stepper.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
}

extension FlexItemCell:StepperDelegate {
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
