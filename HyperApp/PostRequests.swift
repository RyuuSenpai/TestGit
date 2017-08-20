//
//  PostRequests.swift
//  HyperApp
//
//  Created by Killvak on 04/01/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class  PostRequests {

    
    func getCatProductsDetailsData(catID : Int?  ,completed : @escaping ([ProductDetails]?) -> ()) {
        guard let catID = catID else { print("Error in getCatProductsDetailsData Item Id == Nil and that make Infinite Loading  Loop ***") ; return }
        let parameters : Parameters = ["cat_id" : catID]
        print("that is itemID \(catID)")
        print("that is the parameters in Get_ItemById : \(parameters)")
        
        
        CONFIGURATION.timeoutIntervalForResource = 10 // seconds
        print("that is url getCat By ID : \(BASE_URL + GET_ITEM_BY_CAT)")
        let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
        
        Alamofire.request(BASE_URL + GET_ITEM_BY_CAT , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                guard let data = response.result.value else { print(" ProductDetails data returbn == NULL") ; return }
                let json = JSON(data)
//                print(json)
                var productsDetails = [ProductDetails]()
                for i in 0..<json.count {
                let productDetails = ProductDetails(jsonData: json[i])
//                if let imageUrl =  productDetails.image_url
//                {
//                    let productCat = ProductCategories()
//                    productDetails.image_pr = productCat.getImagee(image: imageUrl)
//                }
                    productsDetails.append(productDetails)
                }
                completed(productsDetails)
                break
                
            case .failure(let err as NSError):
                print(response.result.error)
                print("that is the error Descriptio0n : \(err.description)")
                completed(nil)
                break
            default :
                print("Erro in Switch State Ment in getItem by ID Default was Selected")
                completed(nil)
            }
        }
    }
    
    
    func getBrandProductsDetailsData(brand_id : Int  ,completed : @escaping ([ProductDetails]?) -> ()) {
          let parameters : Parameters = ["brand_id" : brand_id]
         print("that is the parameters in getBrandProductsDetailsData : \(parameters)")
        
        
        CONFIGURATION.timeoutIntervalForResource = 10 // seconds
        print("that is url getBrandProductsDetailsData By ID : \(BASE_URL + GET_ITEM_BY_BRAND)")
//        let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
        
        Alamofire.request(BASE_URL + GET_ITEM_BY_BRAND , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                guard let data = response.result.value else { print(" getBrandProductsDetailsData data returbn == NULL") ; return }
                let json = JSON(data)
                //                print(json)
                var productsDetails = [ProductDetails]()
                for i in 0..<json.count {
                    let productDetails = ProductDetails(jsonData: json[i])
                    //                if let imageUrl =  productDetails.image_url
                    //                {
                    //                    let productCat = ProductCategories()
                    //                    productDetails.image_pr = productCat.getImagee(image: imageUrl)
                    //                }
                    productsDetails.append(productDetails)
                }
                completed(productsDetails)
                break
                
            case .failure(let err as NSError):
//                print(response.result.error)
                print("that is the error getBrandProductsDetailsData : \(err.localizedDescription)")
                completed(nil)
                break
            default :
                print("Erro in Switch State Ment in getBrandProductsDetailsData by ID Default was Selected")
                completed(nil)
            }
        }
    }
    
    
    
        
    
    
    func postGetitemreView(itemID : Int ,completed : @escaping ([GetItemReviewModel]?) -> ()) {
        let parameters : Parameters = ["item_id" : itemID]
        print("that is the parameters in postGetitemreView : \(parameters)")
        
        
        CONFIGURATION.timeoutIntervalForResource = 10 // seconds
        print("that is the url in postGetitemreView : \(BASE_URL + GET_ITEM_REVIEW)")

        let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
        
        Alamofire.request(BASE_URL + GET_ITEM_REVIEW , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                guard let data = response.result.value else { print(" ProductDetails data returbn == NULL") ; return }
                let json = JSON(data)
//                 print(" ProductDetails review \(response.result.value)")
                var itemsReview = [GetItemReviewModel]()
                let reviews = json["reviews"]
                for i in reviews {
                    let data = i.1
                    let itemReview = GetItemReviewModel(jsonData: data)
                    let productDetails = ProductDetails(jsonData: data["product"])
                    let userDetails = UserDataModel(jsonData: data["user"])
                    itemReview.userData = userDetails
                    itemReview.productDetails = productDetails
                    itemsReview.append(itemReview)
                }
                print("count of reviews : \(itemsReview.count)")
                completed(itemsReview)
                break
                
            case .failure(let err as NSError):
                print(response.result.error)
                print(response)
                print(response.request)
                
                print("that is the error Descriptio0n : \(err.localizedDescription)")
                completed(nil)
                break
            default :
                print("Erro in Switch State Ment in getItem by ID Default was Selected")
                completed(nil)
            }
        }

  
    }
    
//    func postRequestAlamoFire(parameters : Parameters) -> JSON {
//       
//        
//        Alamofire.request(BASE_URL + GET_ITEM_BY_CAT , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
//            
//            switch(response.result) {
//            case .success(_):
//                guard let data = response.result.value else { print(" postGetitemreView data returbn == NULL") ; return }
//                let json = JSON(data)
//                print(json)
//                return json
//                break
//                
//            case .failure(let err as NSError):
//                print(response.result.error)
//                print(response)
//                print(response.request)
//                
//                print("that is the error Descriptio0n : \(err.description)")
//                return ()
//                break
//            default :
//                print("Erro in Switch State Ment in postGetitemreView by ID Default was Selected")
//                return ()
//            }
//        }
//        return ()
//    }
    
    
    func postSearchService(query : String?,_ min_price : String?,_ max_price : String? ,completed : @escaping ([Search_Data]?) -> ()) {
//        guard let catID = catID else { print("Error in getCatProductsDetailsData Item Id == Nil and that make Infinite Loading  Loop ***") ; return }
        let parameters : Parameters = ["query" : query ?? ""/*,"min_price" : min_price ?? "", "max_price" : max_price ?? ""*/]
        print("that is query \(query)")
        print("that is the parameters in postSearchService : \(parameters)")
        //query,category_id,min_price,max_price,brand_id
        
//        CONFIGURATION.timeoutIntervalForResource = 10 // seconds
        print("that is url postSearchService By ID : \(BASE_URL + POST_SEARCH)")
//        let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
        
        Alamofire.request(BASE_URL + POST_SEARCH , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                guard let data = response.result.value else { print(" ProductDetails data returbn == NULL") ; return }
                let json = JSON(data)
                print(json)
                var dataX = [Search_Data]()
                for items in json {
                    
                    let data = Search_Data(items.1)
                    print("that's the name : \(data.image) price : \(data.name) image : \(data.price)")
                    dataX.append(data)
                }
                
                
                completed(dataX)
                break
                
            case .failure(let err as NSError):
                print(response.result.error)
                print("that is the error Descriptio0n : \(err.description)")
                completed(nil)
                break
            default :
                print("Erro in Switch State Ment in getItem by ID Default was Selected")
                completed(nil)
            }
        }
    }
    
    
}
