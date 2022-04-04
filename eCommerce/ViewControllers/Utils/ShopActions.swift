//
//  ShopActions.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 21/02/22.
//

import UIKit

class ShopActions {
    
    static weak var delegate:CartViewControllerDelegate?
    static weak var favDelegate:FavViewControllerDelegate?
    static weak var stepperDelegate:StepperInCartDelegate?
    static weak var sortDelegate:SortActionDelegate?
    static weak var badgeDelegate:CartBadgeControllerDelegate?
    static weak var cartDelegate:AddtoCartDelegate?
    static weak var cartCollectionDelegate:AddtoCartCollectionDelegate?
    static weak var reloadBookMarksDelegate:reloadBookMarkDelegate?
    static weak var filterDelegate:filterProductsWithFiltersDelegate?
    static weak var commentsDelgate:reloadCommentsDelegate?
    static weak var reloadAccountDelegate:reloadAccountSection?
    
    static func addToCart(product:Product) {
        product.quantitiesSelected = 1
        UserData.user?.addToCart(product)
        print("Added \(product.title!) to cart sucessfully")
        do {
            try UserData.context.save()
            delegate?.reloadCartData()
            badgeDelegate?.reloadCarBadge()
        }catch {
            print("error saving data in cart")
        }
    }
    
    static func removeFromCart(product:Product) {
        UserData.user?.removeFromCart(product)
        print("Removed \(product.title!) to cart sucessfully")
        do {
            try UserData.context.save()
            delegate?.reloadCartData()
            badgeDelegate?.reloadCarBadge()
        }catch {
            print("error removing data in cart")
        }
    }
    
    static func addToFav(product:Product) {
        UserData.user?.addToFavourites(product)
        print("Added \(product.title!) to Fav sucessfully")
        do {
            try UserData.context.save()
            favDelegate?.reloadFavData()
        }catch {
            print("error saving data in cart")
        }
    }
    
    static func removeFromFav(product:Product) {
        UserData.user?.removeFromFavourites(product)
        print("removed \(product.title!) from Fav sucessfully")
        do {
            try UserData.context.save()
            favDelegate?.reloadFavData()
        }catch {
            print("error saving data in cart")
        }
    }
    
    static func updateAddress(user:User,newAddress:String){
        user.address = newAddress
        do {
            try UserData.context.save()
        }catch {
            print("error updating address")
        }
    }
    
    static func addAllToCart(allproduct:[Product]){
        for product in allproduct {
            addToCart(product: product)
        }
    }
    
    static func removeAllFromCart(allproduct:[Product]){
        for product in allproduct {
            removeFromCart(product: product)
        }
    }
    
    static func removeAllFromFav(allproduct:[Product]){
        for product in allproduct {
            removeFromFav(product: product)
        }
    }
    
    static func StepperValuechanged(with:Int,on:Product){
        on.quantitiesSelected = Int64(with)
        do {
            try UserData.context.save()
            favDelegate?.reloadFavData()
        }catch {
            print("error changing stepper value")
        }
        stepperDelegate?.stepperChanged()
    }
    
    static func checkOutProducts(total:Double,paymentMode:Utils.paymentMethods){
        let order = Orders(context: UserData.context)
        order.date = Date()
        order.total = total
        order.paymentMode = paymentMode.rawValue
        order.orderId = String(arc4random())
        guard let itemsInCart = UserData.user?.itemsInCart else {return}
        for product in itemsInCart {
            order.addToItems(product)
        }
        UserData.user?.addToPreviousOrder(order)
        do {
            try UserData.context.save()
            removeAllFromCart(allproduct: itemsInCart)
        }catch {
            print("error creating order")
        }
    }
    
    static func createList(name:String,allProducts:[Product]){
        let list = CustomList(context: UserData.context)
        list.name = name
        for product in allProducts {
            list.addToProductlList(product)
        }
        
        UserData.user?.addToCList(list)
        do {
            try UserData.context.save()
            print("Created list with name \(name) sucessfully")
        }catch {
            print("error creating list")
        }
    }
    
    static func createList(name:String) -> CustomList{
        let list = CustomList(context: UserData.context)
        list.name = name
        UserData.user?.addToCList(list)
        do {
            try UserData.context.save()
            print("Created list with name \(name) sucessfully")
        }catch {
            print("error creating list")
        }
        return list
    }
    
    static func additemsToList(list:CustomList,product:Product){
        for item in UserData.user?.itemsIncList ?? [] {
            if item.id == list.id {
                item.addToProductlList(product)
            }
        }
        do {
            try UserData.context.save()
            print("Added product to list sucessfully")
        }catch {
            print("error saving in list")
        }
    }
    
    static func removeList(list:CustomList){
        UserData.user?.removeFromCList(list)
        do {
            try UserData.context.save()
            favDelegate?.reloadFavData()
            print("removed list sucessfully")
        }catch {
            print("error removing the list")
        }
    }
    
    static func removeProductFromList(list:CustomList,product:Product){
        list.removeFromProductlList(product)
        do {
            try UserData.context.save()
            print("removed product from the list sucessfully")
        }catch {
            print("error removing product from the list")
        }
    }
    
    static func addToUserCoupons(coupon:Coupons){
        UserData.user?.addToAppliedCoupons(coupon)
        do {
            try UserData.context.save()
            print("added to applied coupons sucessfully")
        }catch {
            print("error adding to applied coupons")
        }
    }
    
    static func createNewComment(title:String,starRating:Int,des:String = "",product:Product){
        var desc:String
        if des == "Review (Optional)"{
            desc = ""
        }else {
            desc = des
        }
        
        let comment = Comments(context: UserData.context)
        comment.comment = desc
        comment.title = title
        comment.star = Int64(starRating)
        comment.name = UserData.user?.name
        comment.date = Date()
        product.addToReviews(comment)
        
        UserData.user?.addToReviewedProducts(product)
        do {
            try UserData.context.save()
            print("Created the comment Sucessfully")
        }catch {
            print("error creating the comment")
        }
        
    }
    
    static func addToRecentSearches(product:Product){
        let max = 3
        if UserData.user?.searchedItems.count == max {
            guard let productToRemove = UserData.user?.searchedItems.last else { return }
            UserData.user?.removeFromRecentSearches(productToRemove)
        }
        UserData.user?.addToRecentSearches(product)
        
        do {
            try UserData.context.save()
            print("Added to recent search")
        } catch {
            print("error adding to recent searches")
        }
    }
    
    
    static func addToRecentText(txt:String){
        do {
            let search = RecentText(context: UserData.context)
            search.search = txt
            try UserData.context.save()
        } catch {
            print("error adding to recent searches")
        }
    }

    
    static func reloadComments(){
        commentsDelgate?.reloadCommentsTable()
    }
    
    static func reloadbookmark(){
        reloadBookMarksDelegate?.reloadBookMark()
    }
    
    static func SortProducts(sort:Utils.sortProducts){
        sortDelegate?.sortProducts(sort: sort)
    }
    
    static func reloadCartCell(cell:UITableViewCell){
        cartDelegate?.reloadProductCell(cell: cell)
    }
    
    static func reloadCartCell(cell:UICollectionViewCell){
        cartCollectionDelegate?.reloadProductCell(cell: cell)
    }
    
    static func reloadAccountSections(){
        reloadAccountDelegate?.reloadAccountSection()
    }
    
    static func saveProfileImage(image:Data){
        UserData.user?.userImage = image
        do {
            try UserData.context.save()
            print("Saved image sucessfully")
        }catch {
            print("error saving image")
        }
    }
    
    static func saveUserDetails(name:String,email:String,phone:String,address:String){
        UserData.user?.name = name
        UserData.user?.email = email
        UserData.user?.phone = phone
        UserData.user?.address = address
        do {
            try UserData.context.save()
            print("Saved User Details sucessfully")
        }catch {
            print("error saving user Details")
        }
    }
    
    static func filterAllProducts(){
        filterDelegate?.filterProductsWithFilters()
    }
    
}

protocol CartViewControllerDelegate:AnyObject{
    func reloadCartData()
}

protocol CartBadgeControllerDelegate:AnyObject{
    func reloadCarBadge()
}

protocol FavViewControllerDelegate:AnyObject{
    func reloadFavData()
}

protocol StepperInCartDelegate:AnyObject {
    func stepperChanged()
}

protocol SortActionDelegate:AnyObject {
    func sortProducts(sort:Utils.sortProducts)
}

protocol AddtoCartDelegate:AnyObject {
    func reloadProductCell(cell:UITableViewCell)
}

protocol AddtoCartCollectionDelegate:AnyObject {
    func reloadProductCell(cell:UICollectionViewCell)
}

protocol reloadBookMarkDelegate:AnyObject{
    func reloadBookMark()
}

protocol filterProductsWithFiltersDelegate:AnyObject {
    func filterProductsWithFilters()
}

protocol reloadCommentsDelegate:AnyObject {
    func reloadCommentsTable()
}

protocol reloadAccountSection:AnyObject {
    func reloadAccountSection()
}
