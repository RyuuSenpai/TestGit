//
//  Item+CoreDataProperties.swift
//  HyperApp
//
//  Created by Killvak on 14/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import CoreData 

extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var title: String?
    @NSManaged public var price: Double
    @NSManaged public var prediscountPrice: Double
    @NSManaged public var discountRate: String?
    @NSManaged public var toImage: Image?

}
