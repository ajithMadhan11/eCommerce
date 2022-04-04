//
//  AllProducts.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 19/02/22.
//

import UIKit

class AllProducts: UIViewController {
    
    var headertitle:String? {
        didSet{
            guard let headertitle = headertitle else {return}
            UserData.currentTitle = headertitle
        }
    }
    
    var originalData:[Product] = []
    var filteredData:[Product] = []
    
    private let img:UIImageView = {
        let img = UIImageView(frame: CGRect.zero)
        img.image = UIImage(named: "emptyfav")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let txt:UILabel = {
        let txt = UILabel(frame: CGRect.zero)
        txt.text = "No items found! please change filter options and try again!"
        txt.textColor = .systemGray
        txt.numberOfLines = 2
        txt.textAlignment = .center
        txt.font = UIFont.systemFont(ofSize: 17)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private func runCheck() {
        if filteredData.count == 0 {
            showEmptyFav()
        }else{
            removeEmptyFav()
        }
    }
    
    private func showEmptyFav(){
        self.tableView.isHidden = true
        view.addSubview(img)
        view.addSubview(txt)
        setupEmptyLayout()
    }
    
    private func removeEmptyFav(){
        self.tableView.isHidden = false
        img.removeFromSuperview()
        txt.removeFromSuperview()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupEmptyLayout(){
        NSLayoutConstraint.activate([
            img.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.8),
            img.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.5),
            img.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -30),
            img.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            txt.topAnchor.constraint(equalTo: img.bottomAnchor,constant: -20),
            txt.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            txt.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            txt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavbar()
        setupTableView()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FilterActions.mimPriceDiscount = 100
        FilterActions.mimFilterDiscount = 0
        FilterActions.mimFilterDiscount = 0
        ShopActions.cartDelegate = self
        ShopActions.sortDelegate = self
        ShopActions.filterDelegate = self
        self.tableView.reloadData()
    }
    
    
    private var tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        tableView.register(AllProductCollectionCell.self, forCellReuseIdentifier: AllProductCollectionCell.identifier)
        tableView.register(AllProductsHeader.self, forHeaderFooterViewReuseIdentifier: AllProductsHeader.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    private func setupNavbar(){
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.tintColor = .systemBlue
//        let filterBtn = UIBarButtonItem(title: "filter", style: .plain, target: self, action: #selector(filterBtnTapped))
        let sortbtn = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain,target: self, action: #selector(sortBtnTapped))
        let filterbtn = UIBarButtonItem(image: UIImage(systemName: "slider.vertical.3"), style: .plain,target: self, action: #selector(filterBtnTapped))
        self.navigationItem.rightBarButtonItems = [sortbtn,filterbtn]
        self.navigationItem.title = headertitle
    }
    
    @objc func filterBtnTapped(){
        let viewControllerToPresent = UINavigationController(rootViewController: FilterViewController())
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium(),.large()]
            sheet.preferredCornerRadius = 10
            sheet.prefersGrabberVisible = true
//            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }

    @objc func sortBtnTapped(){
        let viewControllerToPresent = UINavigationController(rootViewController: SortController())
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 10
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
}


extension AllProducts:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AllProductCollectionCell.identifier, for: indexPath) as! AllProductCollectionCell
            cell.collectionView.delegate = self
            cell.currentCategory = self.headertitle
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.index = indexPath
            cell.data = filteredData[indexPath.row - 1]
            if Utils.isProductinUserCart(product: cell.data!){
                cell.addToCartBtn.isHidden = true
                cell.stepper.isHidden = false
            }
            return cell
        }
    }
}



extension AllProducts:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(60)
        }else {
            return CGFloat(120)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            return
        }else{
            let vc = ProductDescriptionViewController()
            vc.data = filteredData[indexPath.row - 1]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension AllProducts:SortActionDelegate {
    
    private func calculateOfferPrice(price:Double,offer:Int64) -> Double{
        let offer:Double = price * (Double(offer) / 100.00)
        return price - offer
    }
    
    func sortProducts(sort: Utils.sortProducts) {
        let sortedProducts:[Product]
        switch sort {
        case .hignToLow :
            sortedProducts  = filteredData.sorted(by: {p1,p2 in
                calculateOfferPrice(price: p1.price,offer: p1.offer) > calculateOfferPrice(price: p2.price,offer: p2.offer)
            })
            filteredData.removeAll()
            filteredData = sortedProducts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .lowToHign:
            sortedProducts  = filteredData.sorted(by: {p1,p2 in
                calculateOfferPrice(price: p1.price,offer: p1.offer) < calculateOfferPrice(price: p2.price,offer: p2.offer)
            })
            filteredData.removeAll()
            filteredData = sortedProducts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .popularity:
            sortedProducts  = filteredData.sorted(by: {p1,p2 in
                Utils.calculateReview(product: p1).0 > Utils.calculateReview(product: p2).0
            })
            filteredData.removeAll()
            filteredData = sortedProducts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .discountPercent:
            sortedProducts  = filteredData.sorted(by: {p1,p2 in
                p1.offer > p2.offer
            })
            filteredData.removeAll()
            filteredData = sortedProducts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
}

extension AllProducts:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if UserData.allCategories?[indexPath.row].name == headertitle {
            return
        }
        guard let category = UserData.allCategories?[indexPath.row] else {return}
        self.headertitle = category.name
        self.filteredData.removeAll()
        self.filteredData = Utils.filterDataWithCategory(category: category.name!)
        self.originalData = self.filteredData
        DispatchQueue.main.async { [weak self] in
            ShopActions.filterAllProducts()
            self?.sortProducts(sort: FilterActions.selectedSort ?? Utils.sortProducts.hignToLow)
            self?.tableView.reloadData()
            self?.navigationItem.title = self?.headertitle
            collectionView.reloadData()
        }
    }
}

extension AllProducts:AddtoCartDelegate {
    func reloadProductCell(cell: UITableViewCell) {
        let cellPath = self.tableView.indexPath(for: cell)
        guard let cellPath = cellPath else {
            print("Cannot find the CellPath")
            return
        }
        self.tableView.reloadRows(at: [cellPath], with: .none)
    }
}



extension AllProducts:filterProductsWithFiltersDelegate {
    
    func filterProductsWithFilters() {
        var newFiltereddata:[Product]
        newFiltereddata = FilterActions.filterByGivenfilters(products: originalData)
        filteredData.removeAll()
        filteredData = newFiltereddata
        runCheck()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}
