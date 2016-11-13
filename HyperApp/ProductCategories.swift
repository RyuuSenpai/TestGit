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
    var products : [productDetails]?



    static func productCategories() -> [ProductCategories] {
        
        let Mobiles = ProductCategories()
        Mobiles.name = "Mobiles"
        
        var products = [productDetails]()
        
        let iPhone = productDetails()
        iPhone.id = 1
        iPhone.name = "iPhone 6"
        iPhone.id_parent = 0
        iPhone.price = 4000
        iPhone.preDiscountPrice = 5500
        products.append(iPhone)
        
        let Samsung = productDetails()
        Samsung.id = 2
        Samsung.name = "Samsung Prime"
        Samsung.id_parent = 0
        Samsung.price = 1
        Samsung.preDiscountPrice = 3500
        products.append(Samsung)
        
        let googlePiexl = productDetails()
        googlePiexl.id = 3
        googlePiexl.name = "google Piexl"
        googlePiexl.id_parent = 0
        googlePiexl.price = 6200
        googlePiexl.preDiscountPrice = 7900
        products.append(googlePiexl)
        Mobiles.products = products
        
        let TV = ProductCategories()
        TV.name = "T.V"
        
        var tvProducts = [productDetails]()
        
        let small = productDetails()
        small.id = 4
        small.name = "Jac 14 inch"
        small.id_parent = 1
        small.price = 4000
        small.preDiscountPrice = 5500
        tvProducts.append(small)
        
        let meduim = productDetails()
        meduim.id = 5
        meduim.name = "Samsung 24 inch"
        meduim.id_parent = 1
        meduim.price = 2500
        meduim.preDiscountPrice = 3500
        tvProducts.append(meduim)
        
        let large = productDetails()
        large.id = 6
        large.name = "Toshipa 56 inch"
        large.id_parent = 1
        large.price = 6200
        large.preDiscountPrice = 7900
        tvProducts.append(large)
        TV.products = tvProducts
        
        return [Mobiles , TV,Mobiles , TV,Mobiles , TV]
    }
    
}

class productDetails :NSObject {
    
    var id : NSNumber?
    var name :String?
    var image_url : String?
    var id_parent : NSNumber?
    var level_depth : NSNumber?
    var price  : NSNumber?
    var preDiscountPrice : NSNumber?
    var isFav : Bool?
    var onCart : Bool?
    
    
}

class CategoryMD :NSObject {
    
    var id : NSNumber?
    var name :String?
    var image_url : String?
    var id_parent : NSNumber?
    var level_depth : NSNumber?
    var price  : NSNumber?
    var preDiscountPrice : NSNumber?
    var isFav : Bool?
    var onCart : Bool?
    
    
}
