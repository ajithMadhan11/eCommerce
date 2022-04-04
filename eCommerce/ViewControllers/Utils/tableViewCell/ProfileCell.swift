//
//  ProfileCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 02/03/22.
//

import UIKit

class ProfileCell: UITableViewCell {
    static let identifier = "ProfileCell"
    
    var data:User? {
        didSet{
            guard let user = data else {return}
            
            self.userName.text = user.name
            self.userEmail.text = user.email
            self.userImage.image = UIImage(data: user.userImage!,scale: 0.1)
        }
    }

    
    private var userImage :UIImageView = {
        let image = UIImageView(frame: CGRect.zero)
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "defaultUser")
        image.clipsToBounds = true
        image.layer.cornerRadius = 35
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
    
    
    private var userEmail :UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "ajith.madhan@zohocorp.com"
        txt.textColor = .systemGray
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userImage)
        contentView.addSubview(userName)
        contentView.addSubview(userEmail)
        setupLayout()
    }
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
        
            userImage.widthAnchor.constraint(equalToConstant: 70),
            userImage.heightAnchor.constraint(equalToConstant: 70),
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            userImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            userName.topAnchor.constraint(equalTo: userImage.bottomAnchor,constant: 10),
            userName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            userEmail.topAnchor.constraint(equalTo: userName.bottomAnchor,constant: 10),
            userEmail.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
