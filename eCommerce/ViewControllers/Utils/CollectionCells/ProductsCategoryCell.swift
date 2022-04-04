//
//  ProductsCategoryCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 01/03/22.
//

import Foundation
import UIKit

class ProductCategoryCell: UICollectionViewCell {
    
    static let identifier = "ProductCategoryCell"
    
//    override var isSelected: Bool {
//       didSet{
//           if self.isSelected {
//               UIView.animate(withDuration: 0.3) {
//                   self.layer.borderColor = UIColor.systemBlue.cgColor
//               }
//           }
//           else {
//               UIView.animate(withDuration: 0.3) {
//                   self.layer.borderColor = UIColor.white.cgColor
//               }
//           }
//       }
//   }
    
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
        img.setContentHuggingPriority(.required, for: .horizontal)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let productName :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Pulse"
        txt.font = UIFont.boldSystemFont(ofSize: 8)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bannerImg)
        contentView.addSubview(productName)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 0.8
        contentView.clipsToBounds = true
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.contentView.layer.borderColor = data?.color?.cgColor
    }
    
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
        
    
            bannerImg.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.7),
            bannerImg.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.3),
            bannerImg.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            bannerImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            
            productName.leadingAnchor.constraint(equalTo: bannerImg.trailingAnchor,constant: 15),
            productName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        
        ])
        
    }
    
}
