//
//  SortController.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 24/02/22.
//

import UIKit

class SortController: UIViewController {
    
    
//    public var itemsInCart:[Product] {
//        let set = cart as? Set<Product> ?? []
//        return set.sorted {
//            $0.title! > $1.title!
//        }
//    }
//
//    public var itemsInFav:[Product] {
//        let set = favourites as? Set<Product> ?? []
//        return set.sorted {
//            $0.title! > $1.title!
//        }
//    }
//
//    public var itemsInPrevOrder:[Orders] {
//        let set = previousOrder as? Set<Orders> ?? []
//        return set.sorted {
//            $0.date! > $1.date!
//        }
//    }
//
//    public var itemsIncList:[CustomList] {
//        let set = cList as? Set<CustomList> ?? []
//        return set.sorted {
//            $0.name! > $1.name!
//        }
//    }
//
//    public var appliedCouponsList:[Coupons] {
//        let set = appliedCoupons as? Set<Coupons> ?? []
//        return set.sorted {
//            $0.code! > $1.code!
//        }
//    }
//
//    public var productsReviedbyUser:[Product] {
//        let set = reviewedProducts as? Set<Product> ?? []
//        return set.sorted {
//            $0.title! > $1.title!
//        }
//    }
//
//    public var searchedItems:[Product]{
//        let set = recentSearches as? Set<Product> ?? []
//        return set.sorted {
//            $0.title! > $1.title!
//        }
//    }
    
    
    let sortValues = [Utils.sortProducts.hignToLow,Utils.sortProducts.lowToHign,Utils.sortProducts.discountPercent,Utils.sortProducts.popularity]
    let sortIcons = ["arrow.up","arrow.down","percent","star.fill"]
    
    let Containertitle:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Sort by "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tableView:UITableView = {
        let tableview = UITableView(frame: CGRect.zero, style: .plain)
        tableview.register(sortCell.self, forCellReuseIdentifier: sortCell.identifier)
        tableview.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = .systemBackground
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(Containertitle)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        setupLayout()
        setupNavbar()
    }
    
    private func setupNavbar(){
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        self.navigationItem.title = "Sort Options"
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            Containertitle.topAnchor.constraint(equalTo: view.topAnchor,constant: 30),
            Containertitle.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            
            tableView.topAnchor.constraint(equalTo: Containertitle.bottomAnchor,constant: 10),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension SortController :UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sortCell.identifier, for: indexPath) as! sortCell
        cell.title.text = sortValues[indexPath.row].rawValue
        cell.icon.image = UIImage(systemName: sortIcons[indexPath.row])
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if FilterActions.selectedSort == sortValues[indexPath.row]{
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ShopActions.SortProducts(sort: sortValues[indexPath.row])
        FilterActions.selectedSort = sortValues[indexPath.row]
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
}


    

