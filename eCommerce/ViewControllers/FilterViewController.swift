//
//  FilterViewController.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 22/03/22.
//

import Foundation
import UIKit

class FilterViewController:UIViewController {
    
    let filterByDiscountOptions:[Utils.filterByDiscount] = [
        Utils.filterByDiscount(min: 10, label: .tenOrMore),
        Utils.filterByDiscount(min: 25, label: .twentyFiveOrMore),
        Utils.filterByDiscount(min: 35, label: .thirtyFiveOrMore),
        Utils.filterByDiscount(min: 50, label: .fiftyOrMore),
        Utils.filterByDiscount(min: 60, label: .sixtyOrMore),
        Utils.filterByDiscount(min: 70, label: .seventyOrMore)
    ]
    
    let filterByPriceOptions:[Utils.filterByPrice] = [
        Utils.filterByPrice(min: 100, label: .allPrices),
        Utils.filterByPrice(min: 1.99, label: .greaterThanTwo),
        Utils.filterByPrice(min: 3.99,  label: .greaterThanFour),
        Utils.filterByPrice(min: 5.99, label: .greaterThanSix),
        Utils.filterByPrice(min: 9.99, label: .greaterThanTen)
    ]
    
    let filterByStarOptions:[Utils.filterByStar] = [
        Utils.filterByStar(min: 1, label: .oneAndMore),
        Utils.filterByStar(min: 2, label: .twoAndMore),
        Utils.filterByStar(min: 3, label: .threeAndMore),
        Utils.filterByStar(min: 4, label: .fourAndMore)
    ]
    
    
    let filterCollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:FilterViewController.makeFilterLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        filterCollectionView.register(FilterCell.self, forCellWithReuseIdentifier: FilterCell.identifier)
        filterCollectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.identifier)
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterCollectionView.backgroundColor = .systemGray6
        filterCollectionView.allowsMultipleSelection = false
        view.addSubview(filterCollectionView)
        
        setupLayout()
        setupNavbar()
    }
    
    private func setupNavbar(){
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        self.navigationItem.title = "Filter Options"
        let applyBtn = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(applyBtnTapped))
        let clearbtn = UIBarButtonItem(title: "Clear filters", style: .plain, target: self, action: #selector(clearBtnTapped))
        self.navigationItem.rightBarButtonItem = applyBtn
        self.navigationItem.leftBarButtonItem = clearbtn
    }
    
    @objc func clearBtnTapped(){
        FilterActions.mimPriceDiscount = 100
        FilterActions.mimFilterDiscount = nil
        FilterActions.mimStarDiscount = nil
        ShopActions.filterAllProducts()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func applyBtnTapped(){
        ShopActions.filterAllProducts()
        ShopActions.SortProducts(sort: FilterActions.selectedSort ?? Utils.sortProducts.lowToHign)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            filterCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            filterCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            filterCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension FilterViewController {
    static func makeFilterLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment:NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let inset: CGFloat = 7
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            
            let group:NSCollectionLayoutGroup
            
            group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), subitem: item, count: 2)
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .absolute(30.0))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            
            section.boundarySupplementaryItems = [header]
            return section
        }
        return layout
    }
    
}

extension FilterViewController:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return filterByDiscountOptions.count
        }else if section == 1 {
            return filterByPriceOptions.count
        }else{
            return filterByStarOptions.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.identifier, for: indexPath) as! HeaderCell
        view.showMoreBtn.isHidden = true
        view.title.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        if indexPath.section == 0 {
            view.title.text = "Filter by Discount"
        }else if indexPath.section == 1 {
            view.title.text = "Filter by Price"
        }else{
            view.title.text = "Filter by Rating"
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.identifier, for: indexPath) as! FilterCell
        if indexPath.section == 0 {
            cell.filterDataByDiscount = filterByDiscountOptions[indexPath.row]
            cell.id = indexPath.row
            if cell.filterDataByDiscount?.min == FilterActions.mimFilterDiscount {
                cell.layer.borderWidth = 1.5
                cell.layer.cornerRadius = 7
                cell.layer.borderColor = UIColor.systemBlue.cgColor
            }
        }else if indexPath.section == 1 {
            cell.filterDataByPrice = filterByPriceOptions[indexPath.row]
            cell.id = indexPath.row
            if cell.filterDataByPrice?.min == FilterActions.mimPriceDiscount {
                cell.layer.borderWidth = 1.5
                cell.layer.cornerRadius = 7
                cell.layer.borderColor = UIColor.systemBlue.cgColor
            }
        }else{
            cell.filterDataByStar = filterByStarOptions[indexPath.row]
            cell.id = indexPath.row
            if cell.filterDataByStar?.min == FilterActions.mimStarDiscount {
                cell.layer.borderWidth = 1.5
                cell.layer.cornerRadius = 7
                cell.layer.borderColor = UIColor.systemBlue.cgColor
            }
        }
        return cell
    }
}



extension FilterViewController:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FilterCell
        if indexPath.section == 0 {
            if cell.filterDataByDiscount?.min == FilterActions.mimFilterDiscount {
                FilterActions.mimFilterDiscount = 0
            }else{
                FilterActions.mimFilterDiscount = cell.filterDataByDiscount?.min
            }
        }else if indexPath.section == 1{
            if cell.filterDataByPrice?.min == FilterActions.mimPriceDiscount {
                FilterActions.mimPriceDiscount = 100
            }else{
                FilterActions.mimPriceDiscount = cell.filterDataByPrice?.min ?? 100
            }
            
        }else{
            if cell.filterDataByStar?.min == FilterActions.mimStarDiscount {
                FilterActions.mimStarDiscount  = 0
            }else {
                FilterActions.mimStarDiscount = cell.filterDataByStar?.min
            }
        }
        self.filterCollectionView.reloadData()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! FilterCell
        if indexPath.section == 0 {
            FilterActions.mimFilterDiscount = 0
//            collectionView.reloadItems(at: [indexPath])
        }else if indexPath.section == 1{
            FilterActions.mimPriceDiscount = 100
//            collectionView.reloadItems(at: [indexPath])
        }else {
            FilterActions.mimStarDiscount = 0
//            collectionView.reloadItems(at: [indexPath])
        }
    }
    
}


