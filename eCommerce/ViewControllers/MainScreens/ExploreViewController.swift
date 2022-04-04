//
//  ExploreViewController.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 18/02/22.
//

import UIKit

class ExploreViewController: UIViewController {
    
    
    var searchTable:SearchResultViewController?
    var searchController :UISearchController!
    var recentSearches:[RecentText] = UserData.searches ?? []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchTable = SearchResultViewController()
        searchController = UISearchController(searchResultsController: searchTable)
        searchController?.searchBar.placeholder = "Search by Product name"
        searchController?.searchBar.becomeFirstResponder()
        setupCollectionView()
        setupNavbar()
        navigationItem.searchController = searchController
        searchController?.searchResultsUpdater = self
        searchController?.searchBar.delegate = self
        searchTable?.tableView.delegate = self
        searchController.searchBar.isTranslucent = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            navigationItem.hidesSearchBarWhenScrolling = false
        searchController?.searchBar.isOpaque = true
    }
    
    private func setupNavbar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemBlue
        self.navigationItem.title = "Search"
    }
    
    private func setupCollectionView(){
        let collectionView = AllCategoryCollectionView()
        collectionView.frame = view.bounds
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
}


extension ExploreViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AllProducts()
        guard let category = UserData.allCategories?[indexPath.row].name else {return}
        vc.headertitle = category
        vc.filteredData.removeAll()
        for data in UserData.allProducts ?? [] {
            guard let cate = data.category else {return}
            if cate == category {
                vc.filteredData.append(data)
            }
        }
        vc.originalData = vc.filteredData
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ExploreViewController:UISearchResultsUpdating,UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchResultsController?.view.isHidden = false
        searchTable?.removenoResult()
        var dataToShow:[Product] = []
        guard var txt = searchController.searchBar.text else {return}
        txt = txt.lowercased()
        if txt == ""{
            searchTable?.filteredData.removeAll()
            searchTable?.tableView.reloadData()
            return
        }
        
        for data in UserData.allProducts ?? [] {
            guard let title = data.title else {return}
            if title.lowercased().contains(txt) {
                dataToShow.append(data)
            }
        }
        searchTable?.filteredData.removeAll()
        searchTable?.filteredData = dataToShow
        
        if dataToShow.count == 0 {
            searchTable?.tableView.isHidden = true
            searchTable?.shownoResult()
        }else{
            searchTable?.tableView.isHidden = false
            searchTable?.removenoResult()
            searchTable?.tableView.reloadData()
        }
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let txt = searchBar.text else {return}
        ShopActions.addToRecentText(txt: txt)
        
        do {
            recentSearches = try UserData.context.fetch(RecentText.fetchRequest())
        }catch{
            print("Error fetching all Searches")
        }
        searchTable?.recentText = recentSearches
        
        DispatchQueue.main.async {
            self.searchTable?.tableView.reloadData()
        }
        
    }
  
}


extension ExploreViewController:UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController.searchBar.endEditing(true)
        let vc = ProductDescriptionViewController()
        if searchTable?.filteredData.count == 0 {
            if indexPath.section == 0 {
                
                do {
                    UserData.searches = try UserData.context.fetch(RecentText.fetchRequest())
                }catch{
                    print("Error fetching data")
                }
                let count = UserData.searches?.count ?? 0
                self.searchController.searchBar.text = UserData.searches?[count - indexPath.row - 1].search
                return
            }
            vc.data = UserData.user?.searchedItems[indexPath.row]
        }else{
            vc.data = searchTable?.filteredData[indexPath.row]
            ShopActions.addToRecentSearches(product: (searchTable?.filteredData[indexPath.row])!)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
