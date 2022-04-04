//
//  SearchResultViewController.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 20/02/22.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var filteredData:[Product] = []
    var recentText:[RecentText] = UserData.searches ?? []
    
    private let img:UIImageView = {
        let img = UIImageView(frame: CGRect.zero)
        img.image = UIImage(named: "noResult")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let txt:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "Oops no results found!?😔"
        txt.textColor = .systemGray
        txt.font = UIFont.systemFont(ofSize: 17)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    func shownoResult(){
        view.addSubview(img)
        view.addSubview(txt)
        setupEmptyLayout()
    }
    
    func removenoResult(){
        img.removeFromSuperview()
        txt.removeFromSuperview()
    }
    
    private func setupEmptyLayout(){
        NSLayoutConstraint.activate([
            img.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.6),
            img.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.5),
            img.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            img.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            txt.topAnchor.constraint(equalTo: img.bottomAnchor,constant: -30),
            txt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    let tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero,style: .plain)
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
        tableView.register(SearchTokenCell.self, forCellReuseIdentifier: SearchTokenCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isHidden = true
        tableView.keyboardDismissMode = .onDrag
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }

    func setupLayout(){
//        tableView.frame = view.bounds
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension SearchResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredData.count != 0 {
            return filteredData.count
        }else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if filteredData.count == 0 {
            if section == 0 {
                return "Recent Searches"
            }else{
                return "Recent Products"
            }
        }
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if filteredData.count == 0 {
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if filteredData.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTokenCell.identifier, for: indexPath) as! SearchTokenCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            if indexPath.section == 0 {
                let count = recentText.count
                cell.text = recentText[count - indexPath.row - 1]
                return cell
            }else{
                cell.data = UserData.user?.searchedItems[indexPath.row]
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as! SearchResultCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.data = filteredData[indexPath.row]
            return cell
        }
      
    }
    
}




