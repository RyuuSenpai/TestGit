//
//  ProductDetails.swift
//  HyperApp
//
//  Created by Killvak on 05/01/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProductDetails  {
    
    var id : Int?
    var name :String?
    var image_url : String?
    var image_pr :UIImage?
    var id_parent : Int?
    var level_depth : NSNumber?
    var price  : Double?
    var preDiscountPrice : NSNumber?
    var isFav : Bool?
    var onCart : Bool?
    var prDescription : String?
    var on_sale : Bool?
    var highlights : String?
    var id_main_category : Int?
    init(jsonData : JSON) {
        self.id = jsonData["id"].intValue
        self.name = jsonData["name"].stringValue
        self.image_url = IMAGE_HOME_PATH + "/" + jsonData["main_image"].stringValue
        self.id_parent =  jsonData["id_category"].intValue
        self.price = jsonData["price"].doubleValue
        self.on_sale = jsonData["on_sale"].boolValue
        self.prDescription = jsonData["description"].stringValue
        self.highlights = jsonData["highlights"].stringValue
        self.id_main_category = jsonData["id_main_category"].intValue
    }
    init() {
        
    }
}
