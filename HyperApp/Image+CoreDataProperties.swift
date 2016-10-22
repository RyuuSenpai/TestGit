//
//  Image+CoreDataProperties.swift
//  HyperApp
//
//  Created by Killvak on 14/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import CoreData
 

extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image");
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var toItem: Item?

}
