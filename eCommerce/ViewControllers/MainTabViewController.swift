//
//  MainTabViewController.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 18/02/22.
//

import Foundation
import UIKit

class MainTabViewbController:UITabBarController,UITabBarControllerDelegate {
    
    //icon arrays
    let images = ["house","magnifyingglass","cart","person"]
    let selectedImages = ["house.fill","magnifyingglass.fill","cart.fill","person.fill"]
    
   
    
    override func viewDidLoad() {
    
        ShopActions.badgeDelegate = self
        //tab items
        let shop = UINavigationController(rootViewController: ShopViewController())
        let explore =  UINavigationController(rootViewController: ExploreViewController())
        let cart = UINavigationController(rootViewController:CartViewController())
//        let favourites = UINavigationController(rootViewController:FavouritesViewController())
        let account = UINavigationController(rootViewController:AccountViewController())
        
        //item title
        shop.title = "Explore"
        explore.title = "Search"
        cart.title = "Cart"
//        favourites.title = "Collections"
        account.title = "Account"
       
        self.tabBar.tintColor = .systemGreen
        //set tab controllers
        self.setViewControllers([shop,explore,cart,account], animated: true)
        
        guard let items = self.tabBar.items else {return}

        //configure tabs
        UITabBar.appearance().backgroundColor = .systemGray6
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: "\(images[i])")
            items[i].selectedImage = UIImage(systemName: "\(selectedImages[i])")
        }
        reloadBadge()
    }
    
    func reloadBadge(){
        if UserData.user?.itemsInCart.count == 0 {
            self.tabBar.items?[2].badgeValue = nil
            return
        }
      self.tabBar.items?[2].badgeValue = String(UserData.user?.itemsInCart.count ?? 0)
    }
    
}
extension MainTabViewbController:CartBadgeControllerDelegate {
    func reloadCarBadge() {
        self.reloadBadge()
    }
}
