//
//  BarView.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 23/02/22.
//

import Foundation
import UIKit

class BarView:UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private let oneBar: UIProgressView = {
        let bar = UIProgressView(progressViewStyle: .bar)
        bar.progress = 20
        bar.progressTintColor = .systemGreen
        bar.trackTintColor = .systemGray4
        bar.layer.cornerRadius = 5
        bar.clipsToBounds = true
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private let starRating:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "1"
        txt.font = UIFont.boldSystemFont(ofSize: 10)
        txt.textColor = .systemGray
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()

    
    private let starRatingImage: UIImageView = {
        let img = UIImageView(frame: CGRect.zero)
        img.image = UIImage(systemName: "star.fill")
        img.tintColor = .systemGray
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    convenience init(frame:CGRect,index:Int,total:Int,setProgress:Float,color:UIColor){
        self.init(frame: frame)
        addSubview(starRating)
        addSubview(starRatingImage)
        addSubview(oneBar)
        starRating.text = "\(index)"
        oneBar.setProgress(setProgress, animated: true)
        oneBar.progressTintColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
        setupBarView()
    }
    
    private func setupBarView(){
        NSLayoutConstraint.activate([
        
            starRating.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5),
            starRating.centerYAnchor.constraint(equalTo: self.centerYAnchor),
           
            starRatingImage.widthAnchor.constraint(equalToConstant: 10),
            starRatingImage.heightAnchor.constraint(equalToConstant: 10),
            starRatingImage.leadingAnchor.constraint(equalTo:  starRating.trailingAnchor,constant: 2),
            starRatingImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
           
            oneBar.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.4),
            oneBar.heightAnchor.constraint(equalToConstant: 4),
            oneBar.leadingAnchor.constraint(equalTo:  starRatingImage.trailingAnchor,constant: 1),
            oneBar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
