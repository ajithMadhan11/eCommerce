//
//  AllCategoryCollectionView.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 20/02/22.
//

import UIKit

class AllCategoryCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: CGRect.zero, collectionViewLayout:UICollectionViewLayout())
        collectionViewLayout = makeLayout()
        self.register(CategoryHomeCell.self, forCellWithReuseIdentifier: CategoryHomeCell.identifier)
        dataSource = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension AllCategoryCollectionView:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return UserData.allCategories?.count ?? 0
     }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryHomeCell.identifier,for: indexPath) as! CategoryHomeCell
        cell.data = UserData.allCategories?[indexPath.row]
        return cell
    }
}


extension AllCategoryCollectionView {
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment:NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            return Utils.configureSection(itemHeight: 1, itemWidth: 1/2, groupHeight: 0.15, groupWidth: 1, ItemCount: 3, hasHeader: false, isVerticalScroll: false, isHorizontal: true )
        }
        return layout
    }
}
