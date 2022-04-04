//
//  AddressCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 02/03/22.
//

import UIKit

class OrdersCell: UITableViewCell {

    static let identifier = "OrdersCell"
    
    var data:Orders? {
        didSet{
            guard let order = data else {return}
            self.orderId.text = "Order ID : #\(order.orderId!)"
            self.date.text = formatDate(date: order.date!)
//            self.total.text = "\(order.broughtItems.count)"
            self.stackview.data = order.broughtItems
            self.totalamt.text = "$\(String(format:"%.2f", order.total))"
            self.paymentMode.text = order.paymentMode
        }
    }
    
    private func formatDate(date:Date) ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        return dateFormatter.string(from: date)
    }
    
    let orderId:UILabel = {
       let txt = UILabel()
        txt.text = "#6373678"
        txt.font = UIFont.boldSystemFont(ofSize: 13)
        txt.textColor = .systemGray
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let paymentMode:UILabel = {
       let txt = UILabel()
        txt.text = "Cash on delivery"
        txt.textColor = .systemGray2
        txt.font = UIFont.systemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let dateText:UILabel = {
       let txt = UILabel()
        txt.text = "Purchased on :"
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let date:UILabel = {
       let txt = UILabel()
        txt.text = "11/03/2000"
        txt.font = UIFont.systemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    lazy var stackview:ImageStackView = {
        let stackView = ImageStackView(frame: CGRect.zero)
        stackView.data = data?.broughtItems
        return stackView
    }()
    
    
    let totalText:UILabel = {
       let txt = UILabel()
        txt.text = "grand Total:"
        txt.font = UIFont.boldSystemFont(ofSize: 14)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let totalamt:UILabel = {
       let txt = UILabel()
        txt.text = "$29.08"
        txt.textColor = .systemGreen
        txt.font = UIFont.boldSystemFont(ofSize: 16)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(orderId)
        contentView.addSubview(paymentMode)
        contentView.addSubview(dateText)
        contentView.addSubview(date)
        contentView.addSubview(totalText)
        contentView.addSubview(totalamt)
        contentView.addSubview(stackview)
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.data = nil
        self.stackview.data = nil
        self.stackview.totalItems = 0
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        
        NSLayoutConstraint.activate([
           
            orderId.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 7),
            orderId.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 7),
            
            paymentMode.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 7),
            paymentMode.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -7),
            
            dateText.topAnchor.constraint(equalTo: orderId.bottomAnchor,constant: 7),
            dateText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 7),
            
            date.topAnchor.constraint(equalTo: orderId.bottomAnchor,constant: 7),
            date.leadingAnchor.constraint(equalTo: dateText.trailingAnchor,constant: 7),
            
//            totalItems.topAnchor.constraint(equalTo: dateText.bottomAnchor,constant: 7),
//            totalItems.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 7),
            
//            total.topAnchor.constraint(equalTo: dateText.bottomAnchor,constant: 7),
//            total.leadingAnchor.constraint(equalTo: totalItems.trailingAnchor,constant: 7),
            totalamt.topAnchor.constraint(equalTo: paymentMode.bottomAnchor,constant: 7),
            totalamt.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -7),
            
            totalText.topAnchor.constraint(equalTo: paymentMode.bottomAnchor,constant: 7),
            totalText.trailingAnchor.constraint(equalTo: totalamt.leadingAnchor,constant: -7),
            
            stackview.topAnchor.constraint(equalTo: dateText.bottomAnchor,constant: 15),
            stackview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 7),
            
            
        ])
    }
    
}
