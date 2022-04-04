//
//  BannerCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 18/02/22.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    static let identifier = "BannerCell"
    
    
    var data:String? {
        didSet{
            guard let data = data else {return}
            self.bannerImg.image = UIImage(named: "\(data)")
        }
    }
    
    private let bannerImg:UIImageView = {
        let img = UIImageView(frame: CGRect.zero)
        img.image = UIImage(named: "banner1")
        img.contentMode = .scaleAspectFill
        img.backgroundColor = .systemBackground
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    public let pageControl:UIPageControl = {
        let pc = UIPageControl(frame: CGRect.zero)
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bannerImg)
        contentView.addSubview(pageControl)
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        setupLayout()
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
        
            bannerImg.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImg.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            bannerImg.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            bannerImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        
        ])
        
    }
    
}
