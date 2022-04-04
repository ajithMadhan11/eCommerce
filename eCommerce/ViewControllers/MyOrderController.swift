//
//  AddressController.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 02/03/22.
//

import UIKit

class MyOrderController: UIViewController {

    private let tableView:UITableView = {
        let tableview = UITableView(frame: CGRect.zero, style: .plain)
        tableview.register(OrdersCell.self, forCellReuseIdentifier: OrdersCell.identifier)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private let img:UIImageView = {
        let img = UIImageView(frame: CGRect.zero)
        img.image = UIImage(named: "emptyOrder")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let txt:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "It seems like you havn't ordered anything yet! 😔"
        txt.textColor = .systemGray
        txt.numberOfLines = 0
        txt.font = UIFont.systemFont(ofSize: 17)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func showEmptyFav(){
        view.addSubview(img)
        view.addSubview(txt)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        setupEmptyLayout()
    }
    
    private func removeEmptyFav(){
        img.removeFromSuperview()
        txt.removeFromSuperview()
    }
    
    private func runcheckUp(){
        if UserData.user?.itemsInPrevOrder.count == 0 {
           showEmptyFav()
        }else {
            removeEmptyFav()
        }
    }
    
    private func setupEmptyLayout(){
        NSLayoutConstraint.activate([
            img.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.5),
            img.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.5),
            img.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            img.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            txt.topAnchor.constraint(equalTo: img.bottomAnchor,constant: -20),
            txt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavbar()
        runcheckUp()
    }
    
    private func setupNavbar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .systemBlue
        self.navigationItem.title = "user Orders"
    }
}

extension MyOrderController:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserData.user?.itemsInPrevOrder.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AllItemListController()
        vc.allItemsToShow = UserData.user?.itemsInPrevOrder[indexPath.row].broughtItems
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrdersCell.identifier, for: indexPath) as! OrdersCell
        cell.data = UserData.user?.itemsInPrevOrder[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
}
