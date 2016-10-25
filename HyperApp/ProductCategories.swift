//
//  productCateories.swift
//  HyperApp
//
//  Created by Killvak on 22/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation

class ProductCategories {
    
    var name : String?
    var categories : [productDetails]?
    
}

class productDetails :NSObject {
    
    var id : Int?
    var name :String?
    var image_url : String?
    var id_parent : Int?
    var level_depth : Int?

    
    
    
    
}
