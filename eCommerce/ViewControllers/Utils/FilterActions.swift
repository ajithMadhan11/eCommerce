//
//  FilterActions.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 23/03/22.
//

import Foundation

final class FilterActions {
    
    static var mimPriceDiscount:Double?
    static var mimFilterDiscount:Int?
    static var mimStarDiscount:Int?
    static var selectedSort:Utils.sortProducts?
    
    static func filterByGivenfilters(products:[Product]) ->[Product] {
        let min:Double = mimPriceDiscount ?? 100
        let minDiscount:Int = mimFilterDiscount ?? 0
        let minStar:Int = mimStarDiscount ?? 0
        
        if minDiscount == 0 && min == 0 && minStar == 0{
            return products
        }
        
        return filterByMin(products: products, min: min, minDiscount: minDiscount,minStar: minStar)
    }
    
    static func filterByMin(products:[Product],min:Double,minDiscount:Int,minStar:Int) ->[Product] {
        var filteredList:[Product] = []
        for product in products {
            let price = calculateProductPrice(product: product)
            let review = Int(Utils.calculateReview(product: product).0)
            
//            if product.offer >= minDiscount && price <= min && Int(Utils.calculateReview(product: product).0) >= minStar {
//                filteredList.append(product)
//            }
            
            if product.offer >= minDiscount {
                print(price,min)
                if price <= min {
                    if review >= minStar {
                        filteredList.append(product)
                    }
                }
            }
        }
        
        return filteredList
    }
    
    static func calculateReview(data:Product) -> Int{
        let totalReviews = data.oneStar + data.twoStar + data.threeStar + data.fourStar + data.fiveStar
        let total = (data.oneStar * 1) + (data.twoStar * 2) + (data.threeStar * 3) + (data.fourStar * 4) + (data.fiveStar * 5)
        let rating:Double = Double(total)/Double(totalReviews)
        return Int(rating)
    }
    
    static func calculateProductPrice(product:Product) -> Double{
        let offer:Double = Double(product.price) * (Double(product.offer) / 100.00)
        return product.price - offer
    }
}
