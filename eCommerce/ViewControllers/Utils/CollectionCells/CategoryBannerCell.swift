//
//  CategoryBannerCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 18/02/22.
//

import UIKit

class CategoryBannerCell: UICollectionViewCell {
    
    static let identifier = "CategoryBannerCell"
    
    
    var data:Category? {
        didSet{
            guard let data = data else {return}
            self.productName.text = data.name
            self.bannerImg.image = UIImage(named: "\(data.image ?? "fruits")" )
            self.contentView.backgroundColor = data.color
            self.contentView.layer.borderColor = data.color?.cgColor
           
        }
    }
    
    var color:UIColor?
    
    private let bannerImg:UIImageView = {
        let img = UIImageView(frame: CGRect.zero)
        img.image = UIImage(named: "pulse")
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let productName :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Pulse"
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bannerImg)
        contentView.addSubview(productName)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 0.4
        contentView.clipsToBounds = true
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
        
    
            bannerImg.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.2),
            bannerImg.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.2),
            bannerImg.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            bannerImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            
            productName.leadingAnchor.constraint(equalTo: bannerImg.trailingAnchor,constant: 10),
            productName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        
        ])
        
    }
    
}
