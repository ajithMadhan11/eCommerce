//
//  ShopViewController.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 18/02/22.
//

import UIKit

class ShopViewController: UIViewController {
    
    var allCategories:[Category]?
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupNavbar()
        setupCollectionView()
        view.backgroundColor = .systemGray5

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavbar()
        self.collectionView.reloadData()
        ShopActions.cartCollectionDelegate = self
        view.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:makeLayout())
    private func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        collectionView.register(Itemcell.self, forCellWithReuseIdentifier: Itemcell.identifier)
        collectionView.register(FlexItemCell.self, forCellWithReuseIdentifier: FlexItemCell.identifier)
        collectionView.register(CategoryHomeCell.self, forCellWithReuseIdentifier: CategoryHomeCell.identifier)
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    private func setupNavbar(){
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Fresh Wagon"
        
    }
}



extension ShopViewController:UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return UserData.bannerImages.count
        case 2 :
            return 8
        case 3 :
            return 12
        case 4:
            return 3
        case 1 :
            return 6
        case 5 :
            return UserData.freshToDoor?.count ?? 0
        default:
            return 0
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.identifier, for: indexPath) as! HeaderCell
        if indexPath.section != 0   {
            view.title.text = UserData.headers[indexPath.section - 1 ]
            if indexPath.section == 4 {
                view.showMoreBtn.isHidden = true
            }
        }
        view.showMoreAction = {
            switch indexPath.section{
            case 1:
                let vc = AllCategory()
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:
                let vc = AllProducts()
                vc.headertitle = UserData.headers[indexPath.section - 1]
                vc.filteredData = UserData.mostRated ?? []
                vc.originalData = vc.filteredData
                self.navigationController?.pushViewController(vc, animated: true)
            case 3:
                let vc = AllProducts()
                vc.headertitle = UserData.headers[indexPath.section - 1]
                vc.filteredData = UserData.allProducts ?? []
                vc.originalData = vc.filteredData
                self.navigationController?.pushViewController(vc, animated: true)
            case 5:
                let vc = AllProducts()
                vc.headertitle = UserData.headers[indexPath.section - 1]
                vc.filteredData = UserData.freshToDoor ?? []
                vc.originalData = vc.filteredData
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                return
            }
        }
        
        return view
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return  createShopControllerCells(collectionView: collectionView, indexPath: indexPath)
    }
}


extension ShopViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let vc = ProductDescriptionViewController()
                vc.data = Utils.findByName(name: "Watermelon")
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 1{
                let vc = ProductDescriptionViewController()
                vc.data = Utils.findByName(name: "Jackfruit")
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = ProductDescriptionViewController()
                vc.data = Utils.findByName(name: "Potato")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case 1:
            let vc = AllProducts()
            guard let category = UserData.allCategories?[indexPath.row] else {return}
            vc.headertitle = category.name
            vc.filteredData.removeAll()
            vc.filteredData = Utils.filterDataWithCategory(category: category.name!)
            vc.originalData = vc.filteredData
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = ProductDescriptionViewController()
            vc.data = UserData.mostRated?[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = ProductDescriptionViewController()
            vc.data = UserData.allProducts?[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            if indexPath.row == 0 {
                let vc = ProductDescriptionViewController()
                vc.data = Utils.findByName(name: "Chicken")
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 1{
                let vc = AllProducts()
                vc.filteredData = UserData.freshToDoor ?? []
                vc.originalData = UserData.freshToDoor ?? []
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = ProductDescriptionViewController()
                vc.data = Utils.findByName(name: "Rice")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case 5:
            let vc = ProductDescriptionViewController()
            vc.data = UserData.freshToDoor?[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
}


extension ShopViewController {
    
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment:NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            if section == 0 {
                return Utils.configureSection(itemHeight: 1, itemWidth: 1, groupHeight: 0.17, groupWidth: 1, ItemCount: 1, hasHeader: false, isVerticalScroll: true, isHorizontal: true,isPagable: false)
            }else if section == 3{
                return Utils.configureSection(itemHeight: 0.33, itemWidth: 1, groupHeight: 0.30, groupWidth: 0.85, ItemCount: 3, hasHeader: true, isVerticalScroll: true, isHorizontal: false,isPagable: false)
            }
            else if section == 1 {
                return Utils.configureSection(itemHeight: 1, itemWidth: 1, groupHeight: 0.15, groupWidth: 1, ItemCount: 3, hasHeader: true, isVerticalScroll: false, isHorizontal: true)
            }
            else if section == 4 {
                return Utils.configureSection(itemHeight: 1, itemWidth: 1, groupHeight: 0.17, groupWidth: 0.95, ItemCount: 1, hasHeader: true, isVerticalScroll: true, isHorizontal: true,isPagable: false)
            }else{
                return Utils.configureSection(itemHeight: 1, itemWidth: 1/2, groupHeight: 0.24, groupWidth: 0.90, ItemCount: 3, hasHeader: true, isVerticalScroll: true, isHorizontal: true,isPagable: false)
            }
        }
        return layout
    }
    
    
    
    func createShopControllerCells(collectionView:UICollectionView,indexPath:IndexPath) -> UICollectionViewCell{
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as! BannerCell
            cell.data = UserData.bannerImages[indexPath.row]
            cell.pageControl.currentPage = indexPath.row
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryHomeCell.identifier, for: indexPath) as! CategoryHomeCell
            cell.data = UserData.allCategories?[indexPath.row]
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Itemcell.identifier, for: indexPath) as! Itemcell
            cell.index = indexPath
            cell.data = UserData.mostRated?[indexPath.row]
            if Utils.isProductinUserCart(product: cell.data!){
                cell.addBtn.isHidden = true
                cell.stepper.isHidden = false
            }
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlexItemCell.identifier, for: indexPath) as! FlexItemCell
            cell.index = indexPath
            cell.data = UserData.allProducts?[indexPath.row]
            if Utils.isProductinUserCart(product: cell.data!){
                cell.addBtn.isHidden = true
                cell.stepper.isHidden = false
            }
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as! BannerCell
            cell.data = UserData.banner2Images[indexPath.row]
            cell.pageControl.currentPage = indexPath.row
            return cell
        case 5:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Itemcell.identifier, for: indexPath) as! Itemcell
            cell.index = indexPath
            cell.data = UserData.freshToDoor?[indexPath.row]
            if Utils.isProductinUserCart(product: cell.data!){
                cell.addBtn.isHidden = true
                cell.stepper.isHidden = false
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Itemcell.identifier,for: indexPath) as! Itemcell
            cell.index = indexPath
            cell.data = UserData.allProducts?[indexPath.row]
            return cell
        }
    }
}

extension ShopViewController:AddtoCartCollectionDelegate {
    
    func reloadProductCell(cell: UICollectionViewCell) {
        let cellPath = self.collectionView.indexPath(for: cell)
        guard let cellPath = cellPath else {
            print("Cannot find the CellPath in collection")
            return
        }
        self.collectionView.reloadItems(at: [cellPath])
    }
}


