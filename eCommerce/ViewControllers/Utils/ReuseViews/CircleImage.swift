//
//  CircleImage.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 07/03/22.
//

import Foundation
import UIKit

class CircleImage:UIImageView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 15
        clipsToBounds = true
        self.contentMode = .scaleAspectFill
        setupLayout()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 30),
            self.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
