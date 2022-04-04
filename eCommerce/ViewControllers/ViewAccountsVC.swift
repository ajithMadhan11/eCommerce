//
//  ViewAccountsVC.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 03/04/22.
//

import Foundation
import UIKit

class ViewAccountsVC:UIViewController {
    
    let tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.register(DetailProfileCell.self, forCellReuseIdentifier: DetailProfileCell.identifier)
        tableView.register(ProfileDetailCell.self, forCellReuseIdentifier: ProfileDetailCell.identifier)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        ShopActions.reloadAccountDelegate = self
        tableView.delegate = self
        setupAccount()
        setupNavbar()
    }
    
    private func setupNavbar(){
        let editBtn = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editBtnTapped))
        self.navigationItem.rightBarButtonItem = editBtn
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    
    
    @objc func editBtnTapped(){
        let rootVc = AccountSettingsVC()
        rootVc.UserDetails = UserData.user
        let viewControllerToPresent = UINavigationController(rootViewController: rootVc)
    
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium(),.large()]
            sheet.preferredCornerRadius = 10
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    
    private func setupAccount(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor,constant: -10),
        ])
    }
}

extension ViewAccountsVC:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 165
        }else{
            return UITableView.automaticDimension
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailProfileCell.identifier, for: indexPath) as! DetailProfileCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.data = UserData.user
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileDetailCell.identifier, for: indexPath) as! ProfileDetailCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.icon.image = UIImage(systemName: "phone.fill")
            cell.title.text = UserData.user?.phone
            return cell
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileDetailCell.identifier, for: indexPath) as! ProfileDetailCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.icon.image = UIImage(systemName: "at")
            cell.title.text = UserData.user?.email
            return cell
        }else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileDetailCell.identifier, for: indexPath) as! ProfileDetailCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.icon.image = UIImage(systemName: "location.fill")
            cell.title.text = UserData.user?.address
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension ViewAccountsVC:reloadAccountSection{
    func reloadAccountSection() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}
