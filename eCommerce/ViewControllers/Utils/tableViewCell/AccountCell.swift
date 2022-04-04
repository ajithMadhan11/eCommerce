//
//  AccountCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 18/03/22.
//

import UIKit

class AccountCell: UITableViewCell {

    static let identifier = "AccountCell"
    
    private let name:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Name"
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.setContentHuggingPriority(.required, for: .horizontal)
        txt.setContentCompressionResistancePriority(.required, for: .horizontal)
        txt.font = UIFont.systemFont(ofSize: 15)
        return txt
    }()
    
    private let nameInput:UITextField = {
        let nameInput = UITextField(frame: CGRect.zero)
        nameInput.placeholder = "User name"
        nameInput.font = UIFont.systemFont(ofSize: 15)
        nameInput.borderStyle = UITextField.BorderStyle.roundedRect
        nameInput.clearButtonMode = UITextField.ViewMode.whileEditing
        nameInput.translatesAutoresizingMaskIntoConstraints = false
        return nameInput
    }()
    
    let nameStack:UIStackView = {
        let ns = UIStackView(frame: CGRect.zero)
        ns.axis = .horizontal
        ns.spacing = 8
        ns.distribution = .fillProportionally
        ns.translatesAutoresizingMaskIntoConstraints = false
        return ns
    }()
        
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameStack)
        nameStack.addArrangedSubview(name)
        nameStack.addArrangedSubview(nameInput)
        setupLayout()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            nameStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameStack.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,constant: 10),
            nameStack.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,constant: -10),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
