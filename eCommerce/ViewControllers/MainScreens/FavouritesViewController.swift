//
//  FavouritesViewController.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 18/02/22.
//

import UIKit

class FavouritesViewController: UIViewController {

    private let tableView:UITableView = {
        let tableview = UITableView(frame: CGRect.zero, style: .plain)
        tableview.register(CollectionCell.self, forCellReuseIdentifier: CollectionCell.identifier)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
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
        txt.text = "Your Collection List is Empty 😔"
        txt.textColor = .systemGray
        txt.font = UIFont.systemFont(ofSize: 17)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
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
    }
    
    private func showEmptyFav(){
        view.addSubview(img)
        view.addSubview(txt)
        setupEmptyLayout()
    }
    
    private func removeEmptyFav(){
        img.removeFromSuperview()
        txt.removeFromSuperview()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShopActions.favDelegate = self
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        setupNavbar()
        runcheckUp()
        
    }
    
    private func setupNavbar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .systemBlue
        let create = UIBarButtonItem(title: "Create List", style: .plain, target: self, action: #selector(createListBtnTapped))
        create.tintColor = .systemTeal
        navigationItem.rightBarButtonItems = [create]
        self.navigationItem.title = "My Collections"
    }
    
    @objc private func createListBtnTapped(){
        let alert = UIAlertController(title: "Enter Title of List", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: {[weak self]_ in
            guard let name = alert.textFields?.last?.text, !name.isEmpty else {  return  }
            let list = ShopActions.createList(name: name)
            let completionAlert = Utils.presentAlert(withTitle: "", message: "New List with title \(list.name ?? "") has been created sucessfully!")
            self?.present(completionAlert, animated: true, completion: nil)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.removeEmptyFav()
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func setupEmptyLayout(){
        NSLayoutConstraint.activate([
            img.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.8),
            img.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.5),
            img.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            
            txt.topAnchor.constraint(equalTo: img.bottomAnchor,constant: -20),
            txt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    

}

extension FavouritesViewController:UITableViewDelegate,UITableViewDataSource {
    
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Remove", handler: {_,_,_ in
            guard let list = UserData.user?.itemsIncList[indexPath.row] else {return}
            ShopActions.removeList(list: list)
            if UserData.user?.itemsIncList.count == 0 {
                self.showEmptyFav()
            }
        })
        let config = UISwipeActionsConfiguration(actions: [action])
        return config
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
}

extension FavouritesViewController :FavViewControllerDelegate {
    func reloadFavData() {
        self.tableView.reloadData()
    }
}
