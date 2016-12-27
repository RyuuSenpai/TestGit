//
//  productCateories.swift
//  HyperApp
//
//  Created by Killvak on 22/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
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
    
//    func getproductDetailsData(itemID : Int?,completed : @escaping (productDetails) -> ()) {
//        guard let itemID = itemID else { print("error Item Id == Nil ***") ; return }
//        let parameters : Parameters = ["item_id" : "\(itemID)"]
//        print("that is the parameters in Get_ItemById : \(parameters)")
//        let header   = [HEADER_ID : HEADER_PASSWORD]
//        Alamofire.request(BASE_URL + GET_ITEM , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseJSON { (response:DataResponse<Any>) in
//            
//            switch(response.result) {
//            case .success(_):
//                if let data = response.result.value as? [Dictionary<String,AnyObject>] {
//                    var mainproductDetail = productDetails()
//                    for prodObj in data {
//                        guard let name = prodObj["name"] as? String , let price = prodObj["price"] as? Double , let id = prodObj["id"] as? Int , let getDescription = prodObj["description"] as? String , let main_image = prodObj["main_image"] as? String
//                            else {
//                                print("faild to get name , price or id of product ")
//                                return }
//                        let productDetail = productDetails()
//                        productDetail.name = name
//                        productDetail.price = price
//                        productDetail.prDescription = getDescription
//                        productDetail.image_url  = IMAGE_HOME_PATH + "/" + main_image
//                        let imageUrl  = IMAGE_HOME_PATH + "/" + main_image
//                        productDetail.image_pr = self.getImagee(image: imageUrl)
//                        productDetail.id = id
//                        
//                        mainproductDetail = productDetail
//                    }
//                    completed(mainproductDetail)
//                    
//                }
//                break
//                
//            case .failure(_):
//                print(response.result.error)
//                break
//                
//            }
//        }
//    }
    /* Test
     URLCache.shared.removeAllCachedResponses()
     
     */
    
    
//    test
//    func downloadHomePageData( compeleted: @escaping ([ProductCategories]) -> ()){
//        /*
//         let header   = [HEADER_ID : HEADER_PASSWORD]
//         Alamofire.request( BASE_URL + HOME_PAGE, headers: header)
//         .responseJSON { response in
//         switch response.result {
//         case .success(_) :
//         
//         break
//         case .failure(let err as NSError) :
//         print("that is the error in HP  GetData : %@",err.description)
//         default :
//         print("Get HP Data is out o f balance")
//         }//Switch
//         }//Alamnofire
//         */
//    }//downloadHomePageData
    
    func downloadHomePageData( compeleted: @escaping ([ProductCategories]) -> ()){
    
                    let query_url = BASE_URL + HOME_PAGE
            
                    // escape your URL
                    let urlAddressEscaped = query_url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            
            let header   = [HEADER_ID : HEADER_PASSWORD]

                    //Request with caching policy
                    var request = URLRequest(url: URL(string: urlAddressEscaped!)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
            request.allHTTPHeaderFields = header
            Alamofire.request(request)
//            Alamofire.request( BASE_URL + HOME_PAGE, headers: header)
                .responseJSON { (response) in
                    switch(response.result) {
                    case .success(_):
                        print("Success")
//                        URLCache.shared.removeAllCachedResponses()
                        let cachedURLResponse = CachedURLResponse(response: response.response!, data: (response.data! as NSData) as Data, userInfo: nil, storagePolicy: .allowed)
                        URLCache.shared.storeCachedResponse(cachedURLResponse, for: response.request!)
                        
                        guard response.result.error == nil else {
                            
                            // got an error in getting the data, need to handle it
                            print("error fetching data from url")
                            print(response.result.error!)
                            return
                            
                        }
                        let json = JSON(data: cachedURLResponse.data) // SwiftyJSON

                       let productCatArray =  self.getJsonDataHomePM(json: json)
                       
                        compeleted(productCatArray)
                        break
                    case .failure(let err as NSError) :
                        print("that is fail i n getting the data Mate : %@",err.debugDescription)
                        if let urlRequest = request.urlRequest {
                            let x = URLCache.shared.cachedResponse(for: urlRequest)
                            guard let cache = x else {
                                compeleted([])
                                return
                            }
                            let json = JSON(data: cache.data) // SwiftyJSON
                            //
                            let productCatArray =  self.getJsonDataHomePM(json: json)
                            
                            compeleted(productCatArray)
                        }
                        
                        break
                    default :
                        print("Problem getting the data Switch eeror ")
                    }
    //                let json = JSON(data: cachedURLResponse.data) // SwiftyJSON
    //                //
    //                print(json) // Test if it works
    //                guard response.result.error == nil else {
    //
    //                    // got an error in getting the data, need to handle it
    //                    print("error fetching data from url")
    //                    print(response.result.error!)
    //                    return
    //
    //                }
    
    //                 URLCache.shared.removeAllCachedResponses()
    //                // do whatever you want with your data here
    //                let json2 = JSON(data: cachedURLResponse.data) // SwiftyJSON
    //                //
    //                print(json2) // Test if it works
            }
        }
    
    

    func getJsonDataHomePM(json : JSON) -> [ProductCategories] {
        var productCatArray = [ProductCategories]()
        for i in 0..<json.count {
            let data = json[i]
            let productCat = ProductCategories()
            productCat.name = data["Catname"].stringValue
            let products = data["Products"]
            var yo = [productDetails]()
            for x in 0..<products.count {
                let y = productDetails(jsonData: products[x])
                yo.append(y)
            }
            productCat.products = yo
            productCatArray.append(productCat)
        }
        return productCatArray
    }
    
    
    //test
    //    func getData( compeleted: @escaping ([ProductCategories]) -> ()){
    //
    //        let query_url = BASE_URL + HOME_PAGE
    //
    //        // escape your URL
    //        let urlAddressEscaped = query_url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
    //
    //
    //        //Request with caching policy
    //        let request = URLRequest(url: URL(string: urlAddressEscaped!)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 20)
    //
    //        Alamofire.request( request).authenticate(user: HEADER_ID, password: HEADER_PASSWORD)
    //            .responseJSON { (response) in
    //
    //                switch(response.result) {
    //                case .success(_):
    //                    print("Success")
    //                    URLCache.shared.removeAllCachedResponses()
    //                    let cachedURLResponse = CachedURLResponse(response: response.response!, data: (response.data! as NSData) as Data, userInfo: nil, storagePolicy: .allowed)
    //                    URLCache.shared.storeCachedResponse(cachedURLResponse, for: response.request!)
    //
    //                    let json = JSON(data: cachedURLResponse.data)
    //
    //
    //                    break
    //                case .failure(let err as NSError) :
    //                    print("that is fail i n getting the data Mate : %@",err.debugDescription)
    //                    if let urlRequest = request.urlRequest {
    //                        let x = URLCache.shared.cachedResponse(for: urlRequest)
    //                        let json = JSON(data: (x?.data)!) // SwiftyJSON
    //                        //
    //                        print(json) // Test if it works
    //                    }
    //                    break
    //                default :
    //                    print("Problem getting the data Switch eeror ")
    //                }
    ////                let json = JSON(data: cachedURLResponse.data) // SwiftyJSON
    ////                //
    ////                print(json) // Test if it works
    ////                guard response.result.error == nil else {
    ////
    ////                    // got an error in getting the data, need to handle it
    ////                    print("error fetching data from url")
    ////                    print(response.result.error!)
    ////                    return
    ////
    ////                }
    //
    ////                 URLCache.shared.removeAllCachedResponses()
    ////                // do whatever you want with your data here
    ////                let json2 = JSON(data: cachedURLResponse.data) // SwiftyJSON
    ////                //
    ////                print(json2) // Test if it works
    //        }
    //    }
    
    //
  
    
    
    func getImagee(image:String) ->UIImage {
        
        let imageURL = URL(string: image)
        if let imageData = NSData(contentsOf: imageURL!){
            return UIImage(data: imageData as Data)!
        }
        return #imageLiteral(resourceName: "PlaceHolder")
        
    }
    
}//class

class productDetails  {
    
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
    
    init(jsonData : JSON) {
        self.id = jsonData["id"].intValue
        self.name = jsonData["name"].stringValue
        self.image_url = IMAGE_HOME_PATH + "/" + jsonData["main_image"].stringValue
        self.id_parent =  jsonData["id_category"].intValue
        self.price = jsonData["price"].doubleValue
        self.on_sale = jsonData["on_sale"].boolValue
        self.prDescription = jsonData["description"].stringValue
    }
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

/*
 func downloadHomePageData( compeleted: @escaping ([ProductCategories]) -> ()){
 getData()
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
 //
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
 
 */
