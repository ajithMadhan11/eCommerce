//
//  Coupons+CoreDataProperties.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 11/03/22.
//
//

import Foundation
import CoreData


extension Coupons {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coupons> {
        return NSFetchRequest<Coupons>(entityName: "Coupons")
    }

    @NSManaged public var code: String?
    @NSManaged public var discount: Double
    @NSManaged public var treshHold: Double
    @NSManaged public var userApplied: NSSet?

}

// MARK: Generated accessors for userApplied
extension Coupons {

    @objc(addUserAppliedObject:)
    @NSManaged public func addToUserApplied(_ value: User)

    @objc(removeUserAppliedObject:)
    @NSManaged public func removeFromUserApplied(_ value: User)

    @objc(addUserApplied:)
    @NSManaged public func addToUserApplied(_ values: NSSet)

    @objc(removeUserApplied:)
    @NSManaged public func removeFromUserApplied(_ values: NSSet)

}

extension Coupons : Identifiable {

}
