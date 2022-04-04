//
//  FilterCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 23/03/22.
//

import Foundation
import UIKit

class FilterCell:UICollectionViewCell {
    
    static let identifier = "FilterCell"
    
    override var isSelected: Bool {
       didSet{
           if self.isSelected {
               UIView.animate(withDuration: 0.3) {
                   self.layer.borderWidth = 1.5
                   self.layer.cornerRadius = 7
                   self.layer.borderColor = UIColor.systemBlue.cgColor
               }
           }
           else {
               UIView.animate(withDuration: 0.3) {
//                   self.layer.borderColor = UIColor.white.cgColor
               }
           }
       }
   }
    
    var filterDataByDiscount:Utils.filterByDiscount? {
        didSet {
            guard let filterData = filterDataByDiscount else {
                return
            }
            self.filterLabel.label.text = filterData.label.rawValue
        }
    }
    
    var selectedStar:Utils.starValues? {
        didSet {
            guard let selectedStar = selectedStar else {
                return
            }
            self.filterLabel.label.text = selectedStar.label.rawValue
        }
    }
    
    var filterDataByPrice:Utils.filterByPrice? {
        didSet {
            guard let filterData = filterDataByPrice else {
                return
            }
            self.filterLabel.label.text = filterData.label.rawValue
        }
    }
    
    var filterDataByStar:Utils.filterByStar? {
        didSet {
            guard let filterData = filterDataByStar else {
                return
            }
            self.filterLabel.label.text = filterData.label.rawValue
        }
    }
    
    
    var id:Int?
    
    var filterLabel:filterlabelView = {
        let view = filterlabelView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(filterLabel)
//        filterLabel.backgroundColor = .white
        self.contentView.layer.borderWidth = 0.6
        self.contentView.layer.borderColor = UIColor.white.cgColor
        self.contentView.layer.cornerRadius = 7
        filterLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        filterLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        filterLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        filterLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        self.backgroundColor = .systemBackground
    }
    
    override func prepareForReuse() {
                self.layer.borderWidth = 0
                self.layer.cornerRadius = 7
//                self.layer.borderColor = UIColor.white.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
