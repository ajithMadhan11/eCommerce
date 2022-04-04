//
//  RecentText+CoreDataProperties.swift
//  eCommerce
//
//  Created by Ajith-pt4498 on 31/03/22.
//
//

import Foundation
import CoreData


extension RecentText {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentText> {
        return NSFetchRequest<RecentText>(entityName: "RecentText")
    }

    @NSManaged public var search: String?

}

extension RecentText : Identifiable {

}
