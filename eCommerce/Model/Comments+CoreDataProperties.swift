//
//  Comments+CoreDataProperties.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 25/03/22.
//
//

import Foundation
import CoreData


extension Comments {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comments> {
        return NSFetchRequest<Comments>(entityName: "Comments")
    }

    @NSManaged public var name: String?
    @NSManaged public var star: Int64
    @NSManaged public var comment: String?
    @NSManaged public var date: Date?
    @NSManaged public var title: String?
    @NSManaged public var productsCommented: NSSet?

}

// MARK: Generated accessors for productsCommented
extension Comments {

    @objc(addProductsCommentedObject:)
    @NSManaged public func addToProductsCommented(_ value: Product)

    @objc(removeProductsCommentedObject:)
    @NSManaged public func removeFromProductsCommented(_ value: Product)

    @objc(addProductsCommented:)
    @NSManaged public func addToProductsCommented(_ values: NSSet)

    @objc(removeProductsCommented:)
    @NSManaged public func removeFromProductsCommented(_ values: NSSet)

}

extension Comments : Identifiable {

}
