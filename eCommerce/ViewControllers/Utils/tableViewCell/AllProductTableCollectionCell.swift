//
//  AllProductTableCollectionCell.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 01/03/22.
//

import Foundation
import UIKit

class AllProductCollectionCell: UITableViewCell {

    static let identifier = "AllProductCollectionCell"
    var currentCategory:String?
 
    
    let collectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:AllProductCollectionCell.makeLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.register(ProductCategoryCell.self, forCellWithReuseIdentifier: ProductCategoryCell.identifier)
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  

}

extension AllProductCollectionCell:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension AllProductCollectionCell:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserData.allCategories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCategoryCell.identifier, for: indexPath) as! ProductCategoryCell
        cell.data = UserData.allCategories?[indexPath.row]
        if UserData.allCategories?[indexPath.row].name == UserData.currentTitle {
            cell.layer.borderWidth = 0.8
            cell.layer.borderColor = UIColor.systemBlue.cgColor
            cell.layer.cornerRadius = 10
            
        }else{
            cell.layer.borderColor = UIColor.clear.cgColor
        }
        return cell
    }
    
   static func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment:NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            return Utils.configureSection(itemHeight: 1, itemWidth: 0.5, groupHeight: 1, groupWidth: 0.85, ItemCount: 3, hasHeader: false, isVerticalScroll: true, isHorizontal: true,isPagable: false)
        }
        return layout
    }
    
}
