//
//  Product+CoreDataProperties.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 30/03/22.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var category: String?
    @NSManaged public var fiveStar: Int64
    @NSManaged public var fourStar: Int64
    @NSManaged public var images: String?
    @NSManaged public var nutritions: String?
    @NSManaged public var offer: Int64
    @NSManaged public var oneStar: Int64
    @NSManaged public var price: Double
    @NSManaged public var productDetails: String?
    @NSManaged public var quantitiesSelected: Int64
    @NSManaged public var quantityDetails: String?
    @NSManaged public var review: Double
    @NSManaged public var threeStar: Int64
    @NSManaged public var title: String?
    @NSManaged public var twoStar: Int64
    @NSManaged public var associatedList: NSSet?
    @NSManaged public var broughtBy: NSSet?
    @NSManaged public var orders: NSSet?
    @NSManaged public var reviewedBy: NSSet?
    @NSManaged public var reviews: NSSet?
    @NSManaged public var searchedBy: User?
    @NSManaged public var userFavourites: NSSet?

    public var itemsInComments:[Comments] {
        let set = reviews as? Set<Comments> ?? []
        return set.sorted {
            $0.date! > $1.date!
        }
    }
}

// MARK: Generated accessors for associatedList
extension Product {

    @objc(addAssociatedListObject:)
    @NSManaged public func addToAssociatedList(_ value: CustomList)

    @objc(removeAssociatedListObject:)
    @NSManaged public func removeFromAssociatedList(_ value: CustomList)

    @objc(addAssociatedList:)
    @NSManaged public func addToAssociatedList(_ values: NSSet)

    @objc(removeAssociatedList:)
    @NSManaged public func removeFromAssociatedList(_ values: NSSet)

}

// MARK: Generated accessors for broughtBy
extension Product {

    @objc(addBroughtByObject:)
    @NSManaged public func addToBroughtBy(_ value: User)

    @objc(removeBroughtByObject:)
    @NSManaged public func removeFromBroughtBy(_ value: User)

    @objc(addBroughtBy:)
    @NSManaged public func addToBroughtBy(_ values: NSSet)

    @objc(removeBroughtBy:)
    @NSManaged public func removeFromBroughtBy(_ values: NSSet)

}

// MARK: Generated accessors for orders
extension Product {

    @objc(addOrdersObject:)
    @NSManaged public func addToOrders(_ value: Orders)

    @objc(removeOrdersObject:)
    @NSManaged public func removeFromOrders(_ value: Orders)

    @objc(addOrders:)
    @NSManaged public func addToOrders(_ values: NSSet)

    @objc(removeOrders:)
    @NSManaged public func removeFromOrders(_ values: NSSet)

}

// MARK: Generated accessors for reviewedBy
extension Product {

    @objc(addReviewedByObject:)
    @NSManaged public func addToReviewedBy(_ value: User)

    @objc(removeReviewedByObject:)
    @NSManaged public func removeFromReviewedBy(_ value: User)

    @objc(addReviewedBy:)
    @NSManaged public func addToReviewedBy(_ values: NSSet)

    @objc(removeReviewedBy:)
    @NSManaged public func removeFromReviewedBy(_ values: NSSet)

}

// MARK: Generated accessors for reviews
extension Product {

    @objc(addReviewsObject:)
    @NSManaged public func addToReviews(_ value: Comments)

    @objc(removeReviewsObject:)
    @NSManaged public func removeFromReviews(_ value: Comments)

    @objc(addReviews:)
    @NSManaged public func addToReviews(_ values: NSSet)

    @objc(removeReviews:)
    @NSManaged public func removeFromReviews(_ values: NSSet)

}

// MARK: Generated accessors for userFavourites
extension Product {

    @objc(addUserFavouritesObject:)
    @NSManaged public func addToUserFavourites(_ value: User)

    @objc(removeUserFavouritesObject:)
    @NSManaged public func removeFromUserFavourites(_ value: User)

    @objc(addUserFavourites:)
    @NSManaged public func addToUserFavourites(_ values: NSSet)

    @objc(removeUserFavourites:)
    @NSManaged public func removeFromUserFavourites(_ values: NSSet)

}

extension Product : Identifiable {

}
