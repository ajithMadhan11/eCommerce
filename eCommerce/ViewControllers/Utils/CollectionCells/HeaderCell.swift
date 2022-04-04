//
//  HeaderCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 18/02/22.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    static let identifier = "HeaderCell"
    
    var showMoreAction:(()->())?
    
    let title:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Exclusive Offer"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let showMoreBtn:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("See All", for: .normal)
        btn.tintColor = .systemBlue
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(showMoreBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    override func prepareForReuse() {
        self.showMoreBtn.isHidden = false
    }
    
    @objc func showMoreBtnTapped(){
        showMoreAction?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(title)
        contentView.addSubview(showMoreBtn)
        setupLayout()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func setupLayout() {
   
        NSLayoutConstraint.activate([
            
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),

            showMoreBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            showMoreBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20)
            
        ])
        
    }
}
