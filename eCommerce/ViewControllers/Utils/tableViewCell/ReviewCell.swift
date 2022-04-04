//
//  ReviewCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 23/02/22.
//

import UIKit

class ReviewCell: UITableViewCell {

    static let identifier = "ReviewCell"
    
    var data:Comments?{
        didSet {
            guard let data = data else {
                return
            }
            self.reviewTitle.text = data.title
            self.starRating.text = "\(data.star)"
            self.reviewDesc.text = data.comment
            self.reviewAuthor.text = "\(data.name!) \(formatDate(date: data.date!))"
        }
    }
    
    private func formatDate(date:Date) ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,YYYY"
        return dateFormatter.string(from: date)
    }
    
    let reviewTitle:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Title"
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.numberOfLines = 1
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    let reviewDesc:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = ""
        txt.font = UIFont.systemFont(ofSize: 13)
        txt.lineBreakMode = .byTruncatingTail
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    var reviewAuthor:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Ajithmadhan 11/03/2000"
        txt.font = UIFont.boldSystemFont(ofSize: 11)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()

    var starRating :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "3"
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.textColor = .systemGray
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    let starRatingImage :UIImageView = {
        let img = UIImageView(frame: CGRect.zero)
        img.image = UIImage(systemName: "star.fill")
        img.contentMode = .scaleAspectFit
        img.tintColor = .systemOrange
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(reviewTitle)
        contentView.addSubview(reviewDesc)
        contentView.addSubview(reviewAuthor)
        contentView.addSubview(starRating)
        contentView.addSubview(starRatingImage)
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        self.backgroundColor = .systemGray5
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
            
            
            starRating.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            starRating.trailingAnchor.constraint(equalTo: starRatingImage.leadingAnchor,constant: -6),
            starRating.widthAnchor.constraint(equalToConstant: 8),
            
            starRatingImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            starRatingImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            starRatingImage.widthAnchor.constraint(equalToConstant: 15),
            starRatingImage.heightAnchor.constraint(equalToConstant: 15),
            
            reviewTitle.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            reviewTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            reviewTitle.trailingAnchor.constraint(equalTo: starRating.leadingAnchor,constant: -10),
            
            reviewDesc.topAnchor.constraint(equalTo: reviewTitle.bottomAnchor,constant: 10),
            reviewDesc.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            reviewDesc.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            
            reviewAuthor.topAnchor.constraint(equalTo: reviewDesc.bottomAnchor,constant: 10),
            reviewAuthor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            reviewAuthor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 10),
            reviewAuthor.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
            
        ])
        
    }
    
}
