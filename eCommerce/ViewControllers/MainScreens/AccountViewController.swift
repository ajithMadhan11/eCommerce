//
//  AccountViewController.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 18/02/22.
//

import UIKit

class AccountViewController: UIViewController {
    
    
    let options:[Utils.UserOptionList] = [
        Utils.UserOptionList(title: "Account Details", icon: "person.crop.circle"),
        Utils.UserOptionList(title: "My Orders", icon: "bag.circle"),
        Utils.UserOptionList(title: "My Collections", icon: "doc.circle"),
    ]
    
    private let tableView:UITableView = {
        let tableview = UITableView(frame: CGRect.zero, style: .plain)
        tableview.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        tableview.register(ProfileListCell.self, forCellReuseIdentifier: ProfileListCell.identifier)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavbar()
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
    }
    
    private func setupNavbar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .systemBlue
        self.navigationItem.title = "My Profile"
    }
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.70),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           
        ])
        
    }
}




extension AccountViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            return
        case 1:
            let vc = ViewAccountsVC()
//            vc.UserDetails = UserData.user
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = MyOrderController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = CollectionViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.data = UserData.user
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileListCell.identifier, for: indexPath) as! ProfileListCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.accessoryType = .disclosureIndicator
            cell.data = options[indexPath.row - 1]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(145)
        }else{
            return CGFloat(60)
        }
    }
}
