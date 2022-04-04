//
//  SelectCollectionVC.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 10/03/22.
//

import Foundation
import UIKit

class SelectCollectionVC:UIViewController{
    
    var product:Product?
    
    private let tableView:UITableView = {
        let tableview = UITableView(frame: CGRect.zero, style: .plain)
        tableview.register(CollectionCell.self, forCellReuseIdentifier: CollectionCell.identifier)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        setupNavbar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupNavbar(){
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        let barBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewCollection))
        let closeBtn = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeBtnTapped))
        self.navigationItem.rightBarButtonItem = barBtn
        self.navigationItem.leftBarButtonItem = closeBtn
        self.navigationController?.navigationBar.tintColor = .systemBlue
        self.navigationItem.title = "Select a Collection"
    }
    
    @objc func closeBtnTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func createNewCollection(){
        
        let alert = UIAlertController(title: "Enter Title of List", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.textFields?[0].delegate = self
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "create", style: .default, handler: {[weak self]_ in
            guard let name = alert.textFields?.last?.text, !name.isEmpty else {  return  }
            let list = ShopActions.createList(name: name)
            guard let product = self?.product else { return }
            ShopActions.additemsToList(list: list, product: product)
            
            let alert = UIAlertController(title: nil, message: "Added \(product.title ?? "") to \(list.name ?? "") ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: { action in
//                alert.dismiss(animated: true, completion: nil)
//                self?.dismiss(animated: true, completion: nil)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }))
            ShopActions.reloadbookmark()
            self?.present(alert, animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension SelectCollectionVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserData.user?.itemsIncList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let list = UserData.user?.itemsIncList[indexPath.row]{
            if Utils.isProductinUserlist(product: product!, list: list){
                let alert = UIAlertController(title: nil, message: "\(product?.title ?? "") is already in the selected list", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            ShopActions.additemsToList(list: list, product: product!)
            let alert = UIAlertController(title: nil, message: "Added \(product?.title ?? "") to \(list.name ?? "") ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: { action in
//                alert.dismiss(animated: true, completion: nil)
//                self.dismiss(animated: true, completion: nil)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }))
            ShopActions.reloadbookmark()
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionCell.identifier, for: indexPath) as! CollectionCell
        cell.name = UserData.user?.itemsIncList[indexPath.row].name
        if Utils.isProductinUserlist(product: product!, list: (UserData.user?.itemsIncList[indexPath.row])!){
            cell.removeBtn.isHidden = false
        }
        
        cell.removeBtnAction = { [weak self] in
            ShopActions.removeProductFromList(list: (UserData.user?.itemsIncList[indexPath.row])!, product: (self?.product)!)
            let alert = UIAlertController(title: nil, message: "Removed \(self?.product?.title ?? "product") from the list", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: { action in
                alert.dismiss(animated: true, completion: nil)
            }))
            ShopActions.reloadbookmark()
            self?.present(alert, animated: true, completion: nil)
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
}

extension SelectCollectionVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 50
    }
}
