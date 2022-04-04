//
//  Orders+CoreDataProperties.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 04/03/22.
//
//

import Foundation
import CoreData


extension Orders {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Orders> {
        return NSFetchRequest<Orders>(entityName: "Orders")
    }

    @NSManaged public var date: Date?
    @NSManaged public var paymentMode: String?
    @NSManaged public var total: Double
    @NSManaged public var orderId: String?
    @NSManaged public var items: NSSet?
    @NSManaged public var userOrders: NSSet?
    
    public var broughtItems:[Product] {
        let set = items as? Set<Product> ?? []
        return set.sorted {
            $0.title! > $1.title!
        }
    }
}

// MARK: Generated accessors for items
extension Orders {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Product)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Product)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

// MARK: Generated accessors for userOrders
extension Orders {

    @objc(addUserOrdersObject:)
    @NSManaged public func addToUserOrders(_ value: User)

    @objc(removeUserOrdersObject:)
    @NSManaged public func removeFromUserOrders(_ value: User)

    @objc(addUserOrders:)
    @NSManaged public func addToUserOrders(_ values: NSSet)

    @objc(removeUserOrders:)
    @NSManaged public func removeFromUserOrders(_ values: NSSet)

}

extension Orders : Identifiable {

}
