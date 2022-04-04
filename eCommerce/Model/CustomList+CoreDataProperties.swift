//
//  CustomList+CoreDataProperties.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 07/03/22.
//
//

import Foundation
import CoreData


extension CustomList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomList> {
        return NSFetchRequest<CustomList>(entityName: "CustomList")
    }

    @NSManaged public var name: String?
    @NSManaged public var productlList: NSSet?
    @NSManaged public var userAssociated: User?

    public var itemsInProductList:[Product] {
        let set = productlList as? Set<Product> ?? []
        return set.sorted {
            $0.title! > $1.title!
        }
    }
}

// MARK: Generated accessors for productlList
extension CustomList {

    @objc(addProductlListObject:)
    @NSManaged public func addToProductlList(_ value: Product)

    @objc(removeProductlListObject:)
    @NSManaged public func removeFromProductlList(_ value: Product)

    @objc(addProductlList:)
    @NSManaged public func addToProductlList(_ values: NSSet)

    @objc(removeProductlList:)
    @NSManaged public func removeFromProductlList(_ values: NSSet)

}

extension CustomList : Identifiable {

}
