//
//  AllCategory.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 20/02/22.
//

import UIKit

class AllCategory: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        setupCollectionView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setupCollectionView(){
        let collectionView = AllCategoryCollectionView()
        collectionView.frame = view.bounds
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    
    private func setupNavbar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemBlue
        self.navigationItem.title = "All Categories"
    }
    
}
extension AllCategory:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AllProducts()
        guard let category = UserData.allCategories?[indexPath.row] else {return}
        vc.headertitle = category.name
        vc.filteredData.removeAll()
        vc.filteredData = Utils.filterDataWithCategory(category: category.name!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


 
    



