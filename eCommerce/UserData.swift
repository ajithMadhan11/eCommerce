//
//  ViewController.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 18/02/22.
//

import UIKit
import CoreData

final class UserData {
    
    static let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let headers = ["Shop by Category","Most Rated","Latest added","Recommended","Fresh to door"]
    static var bannerImages = ["banner1","banner2","banner3"]
    static var banner2Images = ["ban1","ban2","ban3"]
    static var couponImages = ["coupon1","coupon2","coupon3"]
    static var topOffers:[Product]?
    static var mostRated:[Product]?
    static var freshToDoor:[Product]?
    static var allProducts:[Product]?
    static var allCategories:[Category]?
    static var allCoupons:[Coupons]?
    static var searches:[RecentText]?
    static var categories = ["Pulse","Oils","Meat and fish"]
    static var user:User?
    static var currentTitle:String?
    static var homeData:[[Any]]?
    
    static func getCurrentUser() -> User {
        var user:User?
        do{
            let fetchRequest: NSFetchRequest<User>
            fetchRequest = User.fetchRequest()
            fetchRequest.fetchLimit = 1
            user = try context.fetch(fetchRequest).first
            
        }catch {
            print("error fetching user")
        }
        return user!
    }
    
    static func populateAllProducts(){
        
        //        Delete All Products
        
        //                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        //                    fetchRequest.returnsObjectsAsFaults = false
        //                    do {
        //                        let results = try context.fetch(fetchRequest)
        //                        for object in results {
        //                            guard let objectData = object as? NSManagedObject else {continue}
        //                            context.delete(objectData)
        //                            print("Deleted")
        //                        }
        //                    } catch let error {
        //                        print("Detele all data in \("entity") error :", error)
        //                    }
        
        
        
        
        do {
            searches = try UserData.context.fetch(RecentText.fetchRequest())
            allCoupons = try UserData.context.fetch(Coupons.fetchRequest())
            allProducts = try UserData.context.fetch(Product.fetchRequest())
            allCategories = try UserData.context.fetch(Category.fetchRequest())
            
            user = UserData.getCurrentUser()
            
        }catch {
            print("Error")
        }
        
        topOffers = allProducts?.sorted(by:{p1,p2 in p1.offer > p2.offer })
        
        mostRated = allProducts?.sorted(by: {p1,p2 in Utils.calculateReview(product: p1).0 > Utils.calculateReview(product: p2).0 })
        
        freshToDoor = allProducts?.filter({ product in
            if product.category == Categories.Meat.rawValue || product.category == Categories.Fish.rawValue {
                return true
            }
            return  false
        })
        
    }
}

