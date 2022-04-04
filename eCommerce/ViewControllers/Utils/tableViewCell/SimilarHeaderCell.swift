//
//  SimilarHeaderCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 15/03/22.
//

import UIKit

class SimilarHeaderCell: UITableViewCell {

    static let identifier = "SimilarHeaderCell"
    
    var data:String?{
        didSet{
            guard let data = data else {
                return
            }
            self.title.text = data
        }
    }
    
    let title:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Similar Products"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 7)
        ])
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
