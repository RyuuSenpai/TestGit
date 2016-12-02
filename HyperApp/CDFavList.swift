//
//  CDFavList.swift
//  HyperApp
//
//  Created by Killvak on 26/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import RealmSwift

class CDFavList : Object {
  dynamic var image_URL = ""
   dynamic var name  = ""
   dynamic var price : Double = 0.0

    override static func primaryKey() -> String {
        return "name"
    }
}

//class CDOnCart {
//    
//    var name : String?
//    var price : Double?
//    var quantity : Int16?
//    var qXprice : Double?
//    var totalPrice : Double?
//}

class CDSHomePage {
    
    var categoryID : Int32?
    var categoryName : String?
    var name : String?
    var onSale : Bool?
    var prDescription : String?
    var preDiscountPrice : Double?
    var productID : Int32?
    var prPrice : String?
    var quantity : Int32?
}

class CDSHPCategories {
    
    var categoryName : String?
}
