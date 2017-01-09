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
  dynamic var image_url = ""
   dynamic var name  = ""
   dynamic var price : Double = 0.0
    dynamic var imageData : Data? = nil

  dynamic  var id : Int = 0
   dynamic var id_parent : Int = 0
  dynamic  var level_depth : Int = 0
  dynamic  var preDiscountPrice : Double = 0.0
   dynamic var on_sale : Bool = false
    override static func primaryKey() -> String {
        return "name"
    }
}


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
