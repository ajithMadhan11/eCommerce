//
//  Category+CoreDataProperties.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 20/02/22.
//
//

import Foundation
import CoreData
import UIKit

extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var color: UIColor?
    @NSManaged public var image: String?

}

extension Category : Identifiable {

}
