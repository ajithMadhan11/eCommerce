//
//  DescriptionTableViewCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 19/02/22.
//

import Foundation
import UIKit

final class CustomTableTableView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var starRating :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "4.3"
        txt.isHidden = true
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        txt.textColor = .systemPink
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let starRatingImage :UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        img.image = UIImage(systemName: "star.fill")
        img.isHidden = true
        img.tintColor = .systemPink
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
     let title:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Product details"
        txt.textColor = .systemBlue
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let arrow :UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        img.image = UIImage(systemName: "chevron.forward")
        img.contentMode = .scaleAspectFit
        img.tintColor = .systemBlue
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    
    func setupLayout() {
        addSubview(title)
        addSubview(arrow)
        
        addSubview(starRating)
        addSubview(starRatingImage)
        
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7).isActive = true
        
        arrow.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        arrow.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        arrow.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 5).isActive = true
        
        starRating.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        starRating.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        starRating.trailingAnchor.constraint(equalTo: starRatingImage.leadingAnchor, constant: -5).isActive = true
        
        starRatingImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        starRatingImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        starRatingImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    }
}

final class CustomTableDetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     let pDescription:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Average Rating from 234 users"
        txt.numberOfLines = 0
//        txt.lineBreakMode = .byWordWrapping
//        txt.textAlignment = .justified
        txt.font = UIFont.systemFont(ofSize: 12)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
 
    
    func setupLayout() {
        addSubview(pDescription)
        
        pDescription.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        pDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        pDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        pDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
}

class DescriptiontableViewCell:UITableViewCell {
    
     var myText = CustomTableTableView()
     let myDes = CustomTableDetailView()
     let stackView :UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(myText)
        stackView.addArrangedSubview(myDes)
        stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DescriptiontableViewCell {
    
    var isDetailViewHidden: Bool {
        return myDes.isHidden
    }
    
    func showDetailView() {
        myText.arrow.image = UIImage(systemName: "chevron.down")
        myDes.isHidden = false
    }
    
    func hideDetailView() {
        myText.arrow.image = UIImage(systemName: "chevron.forward")
        myDes.isHidden = true
    }
    

}
