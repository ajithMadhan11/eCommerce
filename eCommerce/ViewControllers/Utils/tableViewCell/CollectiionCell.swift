//
//  CollectiionCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 04/03/22.
//

import Foundation
import UIKit

class CollectionCell:UITableViewCell {
   
    static let identifier = "CollectionCell"
    
    var name:String?{
        didSet {
            guard let name = name else { return }
            self.listName.text = name
        }
    }
    
    var removeBtnAction:(()->())?
    
    private var Image :UIImageView = {
        let image = UIImageView(frame: CGRect.zero)
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "doc.circle.fill")
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.tintColor = .systemGreen
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let removeBtn:UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Remove", for: .normal)
        btn.isHidden = true
        btn.addTarget(self, action: #selector(removeBtnTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func removeBtnTapped(){
        removeBtnAction?()
    }
    
    private var listName :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "My Collection"
        txt.font = UIFont.boldSystemFont(ofSize: 13)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(Image)
        contentView.addSubview(listName)
        contentView.addSubview(removeBtn)
        removeBtn.titleLabel!.font = UIFont.systemFont(ofSize: 12)
        setupLayout()
    }
    
    override func prepareForReuse() {
        self.accessoryType = .none
        removeBtn.isHidden = true
        removeBtn.titleLabel!.font = UIFont.systemFont(ofSize: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    private func setupLayout(){
        NSLayoutConstraint.activate([
            Image.widthAnchor.constraint(equalToConstant: 40),
            Image.heightAnchor.constraint(equalToConstant: 40),
            Image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            Image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            listName.leadingAnchor.constraint(equalTo: Image.trailingAnchor,constant: 10),
            listName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            listName.trailingAnchor.constraint(equalTo: removeBtn.leadingAnchor,constant: -10),
        
            removeBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            removeBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
        ])
    }
}
