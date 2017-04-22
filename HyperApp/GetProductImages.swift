//
//  GetProductImages.swift
//  HyperApp
//
//  Created by Killvak on 02/04/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class GetProductImages {
    
    
    
    func getProductImages(product_id : Int?  ,completed : @escaping () -> ()) {
        guard let productId = product_id else { print("Error in getCatProductsDetailsData Item Id == Nil and that make Infinite Loading  Loop ***") ; return }
        let parameters : Parameters = ["product_id" : productId]
        print("that is productId \(productId)")
        print("that is the parameters in Get_ItemById : \(parameters)")
        
        
        CONFIGURATION.timeoutIntervalForResource = 10 // seconds
        
        let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
        
        Alamofire.request(BASE_URL + IMAGE_HOME_PATH , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                guard let data = response.result.value else { print(" ProductDetails data returbn == NULL") ; return }
                let json = JSON(data)
                print("getProductImages \(json)" )
                print("getProductImages \(data)" )
//                let productDetails = ProductDetails(jsonData: json[0])
//                print(productDetails.name,productDetails.price)
//                if let imageUrl =  productDetails.image_url {
//                    let productCat = ProductCategories()
//                    productDetails.image_pr = productCat.getImagee(image: imageUrl)
//                }
                completed( )
                break
                
            case .failure(let err as NSError):
                print(response.result.error)
                print("that is the error Descriptio0n : \(err.description)")
                completed( )
                break
            default :
                print("Erro in Switch State Ment in getItem by ID Default was Selected")
                completed( )
            }
        }
    }
    
    

    
    
    
    
    
}
