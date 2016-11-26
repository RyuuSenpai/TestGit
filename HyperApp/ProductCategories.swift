//
//  productCateories.swift
//  HyperApp
//
//  Created by Killvak on 22/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import Alamofire

class ProductCategories {
    
    var name : String?
    var products : [productDetails]?
    
    
//    static func productCategories() -> [ProductCategories] {
//        
//        let Mobiles = ProductCategories()
//        Mobiles.name = "Mobiles"
//        
//        var products = [productDetails]()
//        
//        let iPhone = productDetails()
//        iPhone.id = 1
//        iPhone.name = "iPhone 6"
//        iPhone.id_parent = 0
//        iPhone.price = 4000
//        iPhone.preDiscountPrice = 5500
//        products.append(iPhone)
//        
//        let Samsung = productDetails()
//        Samsung.id = 2
//        Samsung.name = "Samsung Prime"
//        Samsung.id_parent = 0
//        Samsung.price = 1
//        Samsung.preDiscountPrice = 3500
//        products.append(Samsung)
//        
//        let googlePiexl = productDetails()
//        googlePiexl.id = 3
//        googlePiexl.name = "google Piexl"
//        googlePiexl.id_parent = 0
//        googlePiexl.price = 6200
//        googlePiexl.preDiscountPrice = 7900
//        products.append(googlePiexl)
//        Mobiles.products = products
//        
//        let TV = ProductCategories()
//        TV.name = "T.V"
//        
//        var tvProducts = [productDetails]()
//        
//        let small = productDetails()
//        small.id = 4
//        small.name = "Jac 14 inch"
//        small.id_parent = 1
//        small.price = 4000
//        small.preDiscountPrice = 5500
//        tvProducts.append(small)
//        
//        let meduim = productDetails()
//        meduim.id = 5
//        meduim.name = "Samsung 24 inch"
//        meduim.id_parent = 1
//        meduim.price = 2500
//        meduim.preDiscountPrice = 3500
//        tvProducts.append(meduim)
//        
//        let large = productDetails()
//        large.id = 6
//        large.name = "Toshipa 56 inch"
//        large.id_parent = 1
//        large.price = 6200
//        large.preDiscountPrice = 7900
//        tvProducts.append(large)
//        TV.products = tvProducts
//        
//        return [Mobiles , TV,Mobiles , TV,Mobiles , TV]
//    }

    
    func downloadHomePageData( compeleted: @escaping ([ProductCategories]) -> ()){
        
        let header   = [HEADER_ID : HEADER_PASSWORD]
        Alamofire.request( BASE_URL + HOME_PAGE, headers: header)
            .responseJSON { response in
                var  productCat = [ProductCategories]()
                if let dict = response.result.value as? [Dictionary<String,AnyObject>] {
                    for obj in dict {
                        guard let name = obj["Catname"] as? String , let products = obj["Products"] as? [Dictionary<String,AnyObject>]
                            else {
                                print("failed to get the products or Catname ")
                                return }
                        let prCat = ProductCategories()
                        prCat.name = name
                        var productDetailsA = [productDetails]()
                        for prodObj in products {
                            guard let name = prodObj["name"] as? String , let price = prodObj["price"] as? Double , let id = prodObj["id"] as? Int , let getDescription = prodObj["description"] as? String , let main_image = prodObj["main_image"] as? String
                                else {
                                    print("faild to get name , price or id of product ")
                                    return }
                            let productDetail = productDetails()
                            productDetail.name = name
                                productDetail.price = price
                            productDetail.prDescription = getDescription
                            productDetail.image_url  = IMAGE_HOME_PATH + "/" + main_image
                           let imageUrl  = IMAGE_HOME_PATH + "/" + main_image
                            productDetail.image_pr = self.getImage(image: imageUrl)
                            productDetail.id = id
                            productDetailsA.append(productDetail)
                        }
                        prCat.products = productDetailsA
                        productCat.append(prCat)
                        
                        print(name)
                    }
                    
                }//dict
                compeleted(productCat)
        }//Alamnofire
        
    }//downloadHomePageData
    
    func getImage(image:String) ->UIImage {
        
        let imageURL = URL(string: image)
        if let imageData = NSData(contentsOf: imageURL!){
            return UIImage(data: imageData as Data)!
        }
        return #imageLiteral(resourceName: "PlaceHolder")
        
    }
    
}//class

class productDetails :NSObject {
    
    var id : Int?
    var name :String?
    var image_url : String?
    var image_pr :UIImage?
    var id_parent : NSNumber?
    var level_depth : NSNumber?
    var price  : Double?
    var preDiscountPrice : NSNumber?
    var isFav : Bool?
    var onCart : Bool?
    var prDescription : String?
    
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
