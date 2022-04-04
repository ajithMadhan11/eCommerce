//
//  SimilarProductsTableCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 09/03/22.
//

import Foundation
import UIKit

class SimilarProductsTableCell:UITableViewCell {
    static let identifier = "SimilarProductsTableCell"
    var currentCategory:String?
    var currentProduct:ObjectIdentifier?
 
    
    let collectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:SimilarProductsTableCell.makeLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.register(Itemcell.self, forCellWithReuseIdentifier: Itemcell.identifier)
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.identifier)
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 5),
        ])
    }
  
    
    func reloadCollectionView(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
}


extension SimilarProductsTableCell:UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Utils.filterDataWithCategory(category: currentCategory!,except:currentProduct!).count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Itemcell.identifier, for: indexPath) as! Itemcell
        cell.index = indexPath
        cell.data = Utils.filterDataWithCategory(category: currentCategory!,except:currentProduct!)[indexPath.row]
        if Utils.isProductinUserCart(product: cell.data!){
            cell.addBtn.isHidden = true
            cell.stepper.isHidden = false
        }
        
        return cell
    }
    
   static func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment:NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            return Utils.configureSection(itemHeight: 1, itemWidth: 1/2, groupHeight: 1, groupWidth: 0.90, ItemCount: 3, hasHeader: false, isVerticalScroll: true, isHorizontal: true,isPagable: false)
        }
        return layout
    }
    
}

