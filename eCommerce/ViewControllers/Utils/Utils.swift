//
//  Utils.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 19/02/22.
//

import Foundation
import UIKit

final class Utils {

    enum sortProducts:String {
        case lowToHign = "Price low to high"
        case hignToLow = "Price Hign to low"
        case popularity = "Sort by Popularity"
        case discountPercent = "Sort by % discount"
    }
    
    enum sortReviews:String {
        case favourable = "Most Favourable"
        case critical = "Most Critical"
    }
    
    enum paymentMethods:String {
        case COD = "Cash on Delivery"
        case PAYNOW = "Online Payment"
    }
    
    struct filterByDiscount:Hashable {
        let type = "discount"
        let min:Int
        let label:filterByDiscountConstants
    }
    
    struct filterByPrice:Hashable {
        let type = "price"
        let min:Double
        let label:filterByPriceConstants
    }
    
    struct filterByStar:Hashable {
        let type = "star"
        let min:Int
        let label:filterByStarConstants
    }
    
    enum filterByStarConstants:String {
        case oneAndMore = "⭐ & Up"
        case twoAndMore = "⭐⭐ & Up"
        case threeAndMore = "⭐⭐⭐ & Up"
        case fourAndMore = "⭐⭐⭐⭐ & Up"
    
    }
    
    struct starValues:Hashable {
        let value:Int
        let label:reviewStars
    }
    
    
    enum reviewStars:String {
        case one = "1 ⭐"
        case two = "2 ⭐"
        case three = "3 ⭐"
        case four = "4 ⭐"
        case five = "5 ⭐"
    }
    
    enum filterByDiscountConstants:String {
        case tenOrMore = "10% off or more"
        case twentyFiveOrMore = "25% off or more"
        case thirtyFiveOrMore = "35% off or more"
        case fiftyOrMore = "50% off or more"
        case sixtyOrMore = "60% off or more"
        case seventyOrMore = "70% off or more"
    }
    
    enum filterByPriceConstants:String {
        case allPrices = "All Prices"
        case greaterThanTwo = "lesser than $1.99"
        case greaterThanFour = "lesser than $3.99"
        case greaterThanSix = "lesser than $5.99"
        case greaterThanTen = "lesser than $9.99"
    }
    
    struct UserOptionList {
        let title:String
        let icon:String
    }

    
    static func configureSection(itemHeight:CGFloat,itemWidth:CGFloat,groupHeight:CGFloat,groupWidth:CGFloat,ItemCount:Int,hasHeader:Bool,isVerticalScroll:Bool,isHorizontal:Bool,isPagable:Bool = true) -> NSCollectionLayoutSection{
        
        let inset: CGFloat = 5
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemWidth), heightDimension: .fractionalHeight(itemHeight)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        let group:NSCollectionLayoutGroup
        
        if isHorizontal {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupWidth), heightDimension: .fractionalHeight(groupHeight)), subitem: item, count: ItemCount)
        }else {
            group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupWidth), heightDimension: .fractionalHeight(groupHeight)), subitem: item, count: ItemCount)
        }
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        

        
        let section = NSCollectionLayoutSection(group: group)
        
        if hasHeader {
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .absolute(50.0))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            
            section.boundarySupplementaryItems = [header]
        }
        
        if isVerticalScroll{
            section.orthogonalScrollingBehavior = .groupPaging
        }
        if !isPagable{
            section.orthogonalScrollingBehavior = .continuous
        }
        return section
    }
    
    
//    static func calculateRate(data:Product) -> Double{
//        let totalReviews = data.oneStar + data.twoStar + data.threeStar + data.fourStar + data.fiveStar
//        let total = (data.oneStar * 1) + (data.twoStar * 2) + (data.threeStar * 3) + (data.fourStar * 4) + (data.fiveStar * 5)
//        let rating:Double = Double(total)/Double(totalReviews)
//        return rating
//    }
    
    static func isProductinUserCart(product:Product) -> Bool{
        for item in UserData.user?.itemsInCart ?? [] {
            if item.id == product.id {
                return true
            }
        }
        return false
    }
    
    static func isProductinUserlist(product:Product,list:CustomList) -> Bool{
        for item in list.itemsInProductList {
            if item.id == product.id {
                return true
            }
        }
        return false
    }
    
    static func isUserReviewedTheProduct(product:Product,list:[Product]) -> Bool{
        for item in list {
            if item.id == product.id {
                return true
            }
        }
        return false
    }
    
    static func isProductAddedToAnyList(product:Product) -> Bool {
        for list in UserData.user?.itemsIncList ?? [] {
            if isProductinUserlist(product: product, list: list) {
                return true
            }
        }
        
        return false
    }
    
    
    static func showToast(view:UIView,message : String) {
        let toastLabel = UILabel(frame: CGRect(x:view.frame.size.width/2 - 75, y: view.frame.size.height-60, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.systemFont(ofSize: 16)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 5;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    static func presentAlert(withTitle:String,message:String) -> UIAlertController{
        let alert = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        return alert
    }
    
    static func filterDataWithCategory(category:String) ->[Product]{
        var products:[Product] = []
        for data in UserData.allProducts ?? [] {
            if category == data.category {
                products.append(data)
            }
        }
        return products
    }
    
    static func filterDataWithCategory(category:String,except:ObjectIdentifier) ->[Product]{
        var products:[Product] = []
        for data in UserData.allProducts ?? [] {
            if category == data.category {
                if data.id == except{
                    continue
                }
                products.append(data)
            }
        }
        return products
    }
    
    static func findByName(name:String) ->Product?{
        for data in UserData.allProducts ?? [] {
            if name == data.title {
                return data
            }
        }
        return nil
    }
    
    static func isBroughtByUser(product:Product) ->Bool {
        for order in UserData.user?.itemsInPrevOrder ?? [] {
            for item in order.broughtItems {
                if item.id == product.id {
                    if !isUserReviewedTheProduct(product: product, list: UserData.user?.productsReviedbyUser ?? []) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    static func calculateReview(product:Product) -> (Double,Int){
        var totalCount:Int = 0
        for review in product.itemsInComments {
            totalCount += Int(review.star)
        }
        let starRating = Double(totalCount)/Double(product.itemsInComments.count)
        return (starRating,product.itemsInComments.count)
    }
    
    static func calculateTotalStars(product:Product) -> (Int,Int,Int,Int,Int){
        var one = 0
        var two = 0
        var three = 0
        var four = 0
        var five = 0
        
        for review in product.itemsInComments {
            switch review.star {
            case 1:
                one += 1
            case 2:
                two += 1
            case 3:
                three += 1
            case 4:
                four += 1
            case 5:
                five += 1
            default:
                break
            }
        }
        return (one,two,three,four,five)
    }
   
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidName() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z-]+ ?.*", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}


