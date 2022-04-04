//
//  User+CoreDataProperties.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 31/03/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var address: String?
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var phone: String?
    @NSManaged public var recentText: [String]?
    @NSManaged public var userImage: Data?
    @NSManaged public var appliedCoupons: NSSet?
    @NSManaged public var cart: NSSet?
    @NSManaged public var cList: NSSet?
    @NSManaged public var favourites: NSSet?
    @NSManaged public var previousOrder: NSSet?
    @NSManaged public var recentSearches: NSSet?
    @NSManaged public var reviewedProducts: NSSet?

    public var itemsInCart:[Product] {
        let set = cart as? Set<Product> ?? []
        return set.sorted {
            $0.title! > $1.title!
        }
    }

    public var itemsInFav:[Product] {
        let set = favourites as? Set<Product> ?? []
        return set.sorted {
            $0.title! > $1.title!
        }
    }

    public var itemsInPrevOrder:[Orders] {
        let set = previousOrder as? Set<Orders> ?? []
        return set.sorted {
            $0.date! > $1.date!
        }
    }

    public var itemsIncList:[CustomList] {
        let set = cList as? Set<CustomList> ?? []
        return set.sorted {
            $0.name! > $1.name!
        }
    }

    public var appliedCouponsList:[Coupons] {
        let set = appliedCoupons as? Set<Coupons> ?? []
        return set.sorted {
            $0.code! > $1.code!
        }
    }

    public var productsReviedbyUser:[Product] {
        let set = reviewedProducts as? Set<Product> ?? []
        return set.sorted {
            $0.title! > $1.title!
        }
    }

    public var searchedItems:[Product]{
        let set = recentSearches as? Set<Product> ?? []
        return set.sorted {
            $0.title! > $1.title!
        }
    }
    
}

// MARK: Generated accessors for appliedCoupons
extension User {

    @objc(addAppliedCouponsObject:)
    @NSManaged public func addToAppliedCoupons(_ value: Coupons)

    @objc(removeAppliedCouponsObject:)
    @NSManaged public func removeFromAppliedCoupons(_ value: Coupons)

    @objc(addAppliedCoupons:)
    @NSManaged public func addToAppliedCoupons(_ values: NSSet)

    @objc(removeAppliedCoupons:)
    @NSManaged public func removeFromAppliedCoupons(_ values: NSSet)

}

// MARK: Generated accessors for cart
extension User {

    @objc(addCartObject:)
    @NSManaged public func addToCart(_ value: Product)

    @objc(removeCartObject:)
    @NSManaged public func removeFromCart(_ value: Product)

    @objc(addCart:)
    @NSManaged public func addToCart(_ values: NSSet)

    @objc(removeCart:)
    @NSManaged public func removeFromCart(_ values: NSSet)

}

// MARK: Generated accessors for cList
extension User {

    @objc(addCListObject:)
    @NSManaged public func addToCList(_ value: CustomList)

    @objc(removeCListObject:)
    @NSManaged public func removeFromCList(_ value: CustomList)

    @objc(addCList:)
    @NSManaged public func addToCList(_ values: NSSet)

    @objc(removeCList:)
    @NSManaged public func removeFromCList(_ values: NSSet)

}

// MARK: Generated accessors for favourites
extension User {

    @objc(addFavouritesObject:)
    @NSManaged public func addToFavourites(_ value: Product)

    @objc(removeFavouritesObject:)
    @NSManaged public func removeFromFavourites(_ value: Product)

    @objc(addFavourites:)
    @NSManaged public func addToFavourites(_ values: NSSet)

    @objc(removeFavourites:)
    @NSManaged public func removeFromFavourites(_ values: NSSet)

}

// MARK: Generated accessors for previousOrder
extension User {

    @objc(addPreviousOrderObject:)
    @NSManaged public func addToPreviousOrder(_ value: Orders)

    @objc(removePreviousOrderObject:)
    @NSManaged public func removeFromPreviousOrder(_ value: Orders)

    @objc(addPreviousOrder:)
    @NSManaged public func addToPreviousOrder(_ values: NSSet)

    @objc(removePreviousOrder:)
    @NSManaged public func removeFromPreviousOrder(_ values: NSSet)

}

// MARK: Generated accessors for recentSearches
extension User {

    @objc(addRecentSearchesObject:)
    @NSManaged public func addToRecentSearches(_ value: Product)

    @objc(removeRecentSearchesObject:)
    @NSManaged public func removeFromRecentSearches(_ value: Product)

    @objc(addRecentSearches:)
    @NSManaged public func addToRecentSearches(_ values: NSSet)

    @objc(removeRecentSearches:)
    @NSManaged public func removeFromRecentSearches(_ values: NSSet)

}

// MARK: Generated accessors for reviewedProducts
extension User {

    @objc(addReviewedProductsObject:)
    @NSManaged public func addToReviewedProducts(_ value: Product)

    @objc(removeReviewedProductsObject:)
    @NSManaged public func removeFromReviewedProducts(_ value: Product)

    @objc(addReviewedProducts:)
    @NSManaged public func addToReviewedProducts(_ values: NSSet)

    @objc(removeReviewedProducts:)
    @NSManaged public func removeFromReviewedProducts(_ values: NSSet)

}

extension User : Identifiable {

}
