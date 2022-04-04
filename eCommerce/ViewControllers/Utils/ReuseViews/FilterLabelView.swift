//
//  FilterLabelView.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 23/03/22.
//

import Foundation
import UIKit

class filterlabelView:UIView {
    
    var filterName:String?{
        didSet{
            guard let filterName = filterName else {
                return
            }
            self.label.text = filterName
        }
    }
    
    let label:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "filter"
        txt.font = UIFont.systemFont(ofSize: 15)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        self.backgroundColor = .systemBackground
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        self.layer.borderWidth = 0.4
//        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.cornerRadius = 7
        self.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
