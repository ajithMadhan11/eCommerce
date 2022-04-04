//
//  DetailPrfileCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 03/04/22.
//

import UIKit

class DetailProfileCell: UITableViewCell {
    static let identifier = "DetailProfileCell"
    
    var data:User? {
        didSet{
            guard let user = data else {return}
            
            self.userName.text = user.name
            self.userImage.image = UIImage(data: user.userImage!,scale: 0.1)
        }
    }

    
    private var userImage :UIImageView = {
        let image = UIImageView(frame: CGRect.zero)
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "defaultUser")
        image.clipsToBounds = true
        image.layer.cornerRadius = 60
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    
    private var userName :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Ajithmadhan"
        txt.font = UIFont.boldSystemFont(ofSize: 18)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userImage)
        contentView.addSubview(userName)
        setupLayout()
    }
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
        
            userImage.widthAnchor.constraint(equalToConstant: 120),
            userImage.heightAnchor.constraint(equalToConstant: 120),
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            userImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            userName.topAnchor.constraint(equalTo: userImage.bottomAnchor,constant: 10),
            userName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
