//
//  CollectionViewController.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 04/03/22.
//

import Foundation
import UIKit

class CollectionViewController:UIViewController {
    
    private let img:UIImageView = {
        let img = UIImageView(frame: CGRect.zero)
        img.image = UIImage(named: "emptyfav")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let txt:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Your Collection List is Empty 😔"
        txt.textColor = .systemGray
        txt.font = UIFont.systemFont(ofSize: 17)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private let tableView:UITableView = {
        let tableview = UITableView(frame: CGRect.zero, style: .plain)
        tableview.register(CollectionCell.self, forCellReuseIdentifier: CollectionCell.identifier)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private func runcheckUp(){
        if UserData.user?.itemsIncList.count == 0 {
           showEmptyFav()
        }else {
            removeEmptyFav()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       runcheckUp()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        setupNavbar()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(img)
        view.addSubview(txt)
        setupEmptyLayout()
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    private func setupEmptyLayout(){
        NSLayoutConstraint.activate([
            img.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.8),
            img.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.5),
            img.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            
            txt.topAnchor.constraint(equalTo: img.bottomAnchor,constant: -20),
            txt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupNavbar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .systemBlue
        self.navigationItem.title = "user Collections"
    }
}

extension CollectionViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserData.user?.itemsIncList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AllItemListController()
        vc.allItemsToShow = UserData.user?.itemsIncList[indexPath.row].itemsInProductList
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionCell.identifier, for: indexPath) as! CollectionCell
        cell.name = UserData.user?.itemsIncList[indexPath.row].name
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Remove", handler: {_,_,_ in
            guard let list = UserData.user?.itemsIncList[indexPath.row] else {return}
            ShopActions.removeList(list: list)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            if UserData.user?.itemsIncList.count == 0 {
                self.showEmptyFav()
            }
        })
        
        let config = UISwipeActionsConfiguration(actions: [action])
        return config
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
}
