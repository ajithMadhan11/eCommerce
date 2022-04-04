//
//  ImageStackView.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 07/03/22.
//

import Foundation
import UIKit

class ImageStackView:UIStackView {
    
    public var totalItems:Int = 5
    
    var data:[Product]?{
        didSet{
            guard let products = data else { return }
            generateImageViews(num: products.count)
            if products.count <= totalItems {
                total.text = " "
            }else {
                total.text = "  + \(products.count - totalItems)"
            }
        }
    }
    
    private func generateImageViews(num:Int){
        var count:Int = totalItems
        if num <= totalItems {
            count = num
        }
        for item in 0..<count{
            let imageView = CircleImage(frame: CGRect.zero)
            imageView.image = UIImage(named: "\(data?[item].images ?? "default")")
            self.addArrangedSubview(imageView)
        }
            addArrangedSubview(total)
        
    }
    
    lazy private var total:UILabel = {
           let txt = UILabel()
            txt.font = UIFont.systemFont(ofSize: 12)
            txt.translatesAutoresizingMaskIntoConstraints = false
            return txt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.spacing = 2
        self.translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        setupLayout()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 30),
            self.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
