//
//  CDOnCart.swift
//  HyperApp
//
//  Created by Killvak on 29/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import RealmSwift

class CDOnCart : Object{
    
    dynamic var name : String  = ""
    dynamic var price : Double = 0
    dynamic  var quantity : Int16 = 1
    dynamic  var qXprice : Double = 0.0
    dynamic var totalPrice : Double = 0.0
    dynamic var imgString : String  = ""
    dynamic var imageData : Data? = nil
    
    override static func primaryKey() -> String {
        return "name"
    }
    
}
