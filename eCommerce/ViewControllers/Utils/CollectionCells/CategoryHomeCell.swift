//
//  CategoryHomeCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 21/03/22.
//

import Foundation
import UIKit

class CategoryHomeCell: UICollectionViewCell {
    
    static let identifier = "CategoryHomeCell"
    
    
    var data:Category? {
        didSet{
            guard let data = data else {return}
            self.productName.text = data.name
            self.bannerImg.image = UIImage(named: "\(data.image ?? "fruits")" )
        }
    }
    
    
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
        txt.font = UIFont.boldSystemFont(ofSize: 12)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bannerImg)
        contentView.addSubview(productName)
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 0.4
//        contentView.backgroundColor = .systemGray6
        contentView.layer.borderColor = UIColor.systemGray2.cgColor
        contentView.clipsToBounds = true
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
        
    
            bannerImg.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.5),
            bannerImg.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.5),
            bannerImg.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bannerImg.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15),
            
            productName.topAnchor.constraint(equalTo: bannerImg.bottomAnchor,constant: 10),
            productName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
        
        ])
        
    }
    
}
