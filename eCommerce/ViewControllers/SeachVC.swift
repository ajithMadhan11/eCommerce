//
//  SeachVC.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 22/03/22.
//

import Foundation

import UIKit

class SeachVC:UITableViewController {
    
    var resultsTableViewController:SearchResultViewController!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
      super.viewDidLoad()
      resultsTableViewController =  SearchResultViewController()
//      resultsTableViewController.delegate = self
      searchController = UISearchController(searchResultsController: resultsTableViewController)
      navigationItem.searchController = searchController
      searchController.searchBar.searchTextField.tokenBackgroundColor = .systemBlue
      searchController.searchBar.placeholder = "Search By Products"
      searchController.searchBar.delegate = self
      searchController.searchResultsUpdater = self
      searchController.searchBar.setImage(UIImage(systemName: "slider.vertical.3"), for: .bookmark, state: .normal)
      searchController.searchBar.showsBookmarkButton = true
    }
    
    func searchFor(_ searchText: String?) {
      guard searchController.isActive else { return }
      guard var searchText = searchText else {
        resultsTableViewController.filteredData = []
        return
      }
        searchText = searchText.lowercased()
        resultsTableViewController?.filteredData.removeAll()
        for data in UserData.allProducts ?? [] {
            guard let title = data.title else {return}
            if title.lowercased().contains(searchText) {
                resultsTableViewController?.filteredData.append(data)
            }
        }
        resultsTableViewController?.tableView.reloadData()
    }
}

extension SeachVC: UISearchBarDelegate {
    
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    searchFor(searchText)
  }
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    resultsTableViewController.filteredData = []
    searchController.searchBar.searchTextField.backgroundColor = nil
  }
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.endEditing(true)
  }
}

extension SeachVC: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
      guard var txt = searchController.searchBar.text else {return}
      txt = txt.lowercased()
      resultsTableViewController?.filteredData.removeAll()
      for data in UserData.allProducts ?? [] {
          guard let title = data.title else {return}
          if title.lowercased().contains(txt) {
              resultsTableViewController?.filteredData.append(data)
          }
      }
      resultsTableViewController?.tableView.reloadData()
  }
}

//extension SeachVC: ResultsTableViewDelegate {
//  func didSelect(token: UISearchToken) {
//    let searchTextField = searchController.searchBar.searchTextField
//    searchTextField.insertToken(token, at: searchTextField.tokens.count)
//    searchFor(searchController.searchBar.text)
//  }
//}

//var searchTokens: [UISearchToken] = []
//
//
//weak var delegate:ResultsTableViewDelegate?

//extension SearchResultViewController {
//    func makeTokens() {
//        let allOptions = Utils.filterOptions.allCases
//        searchTokens = allOptions.map { (option) -> UISearchToken in
//            let token = UISearchToken(icon: nil, text: option.rawValue)
//            token.representedObject =  Utils.filterOptions(rawValue: option.description)
//            return token
//        }
//    }
//}
//
//
//protocol ResultsTableViewDelegate: AnyObject {
//    func didSelect(token: UISearchToken)
//}
