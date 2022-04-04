//
//  AllItemListController.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 04/03/22.
//

import Foundation
import UIKit

class AllItemListController:UIViewController  {
    
    var allItemsToShow:[Product]?
    
    private let tableView:UITableView = {
        let tableview = UITableView(frame: CGRect.zero, style: .plain)
        tableview.register(FavouritesCell.self, forCellReuseIdentifier: FavouritesCell.identifier)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    private let addAlltBtn:UIButton = {
        let btn = UIButton(type: .custom)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "cart")
        config.title = "Add all to Cart"
        config.imagePadding = 10
        config.imagePlacement = .leading
        config.background.backgroundColor = .systemGreen
        config.baseForegroundColor = .white
        btn.configuration = config
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(addAllToCartClicked), for: .touchUpInside)
        return btn
    }()
    
    private let img:UIImageView = {
        let img = UIImageView(frame: CGRect.zero)
        img.image = UIImage(named: "emptyfav")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let txt:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Your products found here! 😔"
        txt.textColor = .systemGray
        txt.font = UIFont.systemFont(ofSize: 17)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    @objc func addAllToCartClicked(){
        ShopActions.addAllToCart(allproduct: allItemsToShow ?? [])
        let alert = UIAlertController(title: "Added Sucessfully!", message: "All items in your favorites list added to Cart", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if allItemsToShow?.count == 0 {
           showEmptyFav()
        }else {
            removeEmptyFav()
        }
    }
    
    private func showEmptyFav(){
        view.addSubview(img)
        view.addSubview(txt)
        addAlltBtn.isHidden = true
        setupEmptyLayout()
    }
    
    private func removeEmptyFav(){
        img.removeFromSuperview()
        txt.removeFromSuperview()
        addAlltBtn.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(img)
        view.addSubview(txt)
        tableView.delegate = self
        tableView.dataSource = self
        setupNavbar()
        view.addSubview(addAlltBtn)
        setupLayout()
        setupEmptyLayout()
        
    }
    
    private func setupNavbar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .systemBlue
    }
    
    private func setupEmptyLayout(){
        NSLayoutConstraint.activate([
            img.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.8),
            img.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.5),
            img.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            
            txt.topAnchor.constraint(equalTo: img.bottomAnchor,constant: -20),
            txt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            txt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    private func setupLayout(){

        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.70),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            
            addAlltBtn.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.9),
            addAlltBtn.heightAnchor.constraint(equalToConstant: 60),
            addAlltBtn.topAnchor.constraint(equalTo: tableView.bottomAnchor,constant: 5),
            addAlltBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
        ])

    }
    
}

extension AllItemListController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItemsToShow?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductDescriptionViewController()
        vc.data = allItemsToShow?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesCell.identifier, for: indexPath) as! FavouritesCell
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.data = allItemsToShow?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    
}
