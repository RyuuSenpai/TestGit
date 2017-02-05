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
    
    var catDetails : CategoryDetailsModel?
    var name : String?
    var products : [ProductDetails]?
    let configuration = URLSessionConfiguration.default

    func getproductDetailsData(itemID : Int?,completed : @escaping (ProductDetails?) -> ()) {
        guard let itemID = itemID else { print("Error in getproductDetailsData Item Id == Nil and that make Infinite Loading  Loop ***") ; return }
        let parameters : Parameters = ["item_id" : itemID]
        
 
         configuration.timeoutIntervalForResource = 10 // seconds
         
         let alamofireManager = Alamofire.SessionManager(configuration: configuration)
 
        Alamofire.request(BASE_URL + GET_ITEM , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                guard let data = response.result.value else { print(" ProductDetails data returbn == NULL") ; return }
                let json = JSON(data)
                    let productDetails = ProductDetails(jsonData: json[0])
                if let imageUrl =  productDetails.image_url {
                productDetails.image_pr = self.getImagee(image: imageUrl)
                }
                completed(productDetails)
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
    /* Test
     URLCache.shared.removeAllCachedResponses()
     
     */
    
    func alamoRequest (query_url : String ) -> URLRequest {
        
        // escape your URL
        let urlAddressEscaped = query_url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        let header   = [HEADER_ID : HEADER_PASSWORD]
        
        //Request with caching policy
        var request = URLRequest(url: URL(string: urlAddressEscaped!)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
        request.allHTTPHeaderFields = header
       return  request
    }
    
    
    func downloadHomePageData( pageNum : Int ,compeleted: @escaping ([ProductCategories]) -> ()){
        
        var query_url : String!
        if pageNum == 1 {
             query_url = BASE_URL + HOME_PAGE

        }else {
             query_url = BASE_URL + HOME_PAGE + "/page/\(pageNum)"
 
        }
        print("that is the url for homepage Data  :  " , query_url)
        let request = alamoRequest(query_url: query_url)
            Alamofire.request(request)
                .responseJSON { (response) in
                    switch(response.result) {
                    case .success(_):
                        print("Success")
//                        URLCache.shared.removeAllCachedResponses()
                        let cachedURLResponse = CachedURLResponse(response: response.response!, data: (response.data! as NSData) as Data, userInfo: nil, storagePolicy: .allowed)
                        URLCache.shared.storeCachedResponse(cachedURLResponse, for: response.request!)
                        print("Killva: HomepageData : ",response.result.value)
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

            }
        }
    
    
    
    
    
    func getAllCategories( pageNum : Int ,compeleted: @escaping ([GetAllCategoriesModel]) -> ()){
//        let query_url = BASE_URL + GET_ALL_CATEGORIES 
        var query_url : String!
        if pageNum == 1 {
              query_url = "http://hyper-testing.herokuapp.com/GetAllCategories/"

        }else {
         query_url = "http://hyper-testing.herokuapp.com/GetAllCategories/page/\(2)"
        }

        print("GetAllCategories Url link : " ,query_url)
        let request = alamoRequest(query_url: query_url)
        

        Alamofire.request(query_url, headers: HEADER).responseJSON { (response) in
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
//                print("Killva: That is getAllCategories response :  " , response.result.value )
                let json = JSON(data: cachedURLResponse.data) // SwiftyJSON
                let productCatArray =  self.getJsonCategoriesData(json: json)
                
                compeleted(productCatArray)
                break
            case .failure(let err as NSError) :
                print("Killva: that is response :  \(response.result.debugDescription) and that is the error withgetting the data Mate : %@",err.localizedDescription)
                if let urlRequest = request.urlRequest {
                    let x = URLCache.shared.cachedResponse(for: urlRequest)
                    guard let cache = x else {
                        compeleted([])
                        return
                    }
                    let json = JSON(data: cache.data) // SwiftyJSON
                    //
                    let productCatArray =  self.getJsonCategoriesData(json: json)
                    
                    compeleted(productCatArray)
                }
                
                break
            default :
                print("Problem getting the data Switch eeror ")
            }
            
        }
    
    }
    
    
    
    func z() {
        
//        let query_url = BASE_URL + HOME_PAGE
        
        let headers: HTTPHeaders = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json"
        ]
//        let query_url = BASE_URL + HOME_PAGE + "\(2)"
        let query_url = "http://hyper-testing.herokuapp.com/GetAllCategories/"
        Alamofire.request(query_url, headers: HEADER).responseJSON { response in
//            print(response.result.value)
            debugPrint(response)
        }
        
    }

    
    
    
    

    func getJsonDataHomePM(json : JSON) -> [ProductCategories] {
        var productCatArray = [ProductCategories]()
        for i in 0..<json.count {
            let data = json[i]
            let productCat = ProductCategories()
            // stage API
//            productCat.name = data["Catname"].stringValue
            //testing API
            let catDetail = CategoryDetailsModel(jsonData: data["category"])
            
            let products = data["Products"]
            var yo = [ProductDetails]()
            for x in 0..<products.count {
                let y = ProductDetails(jsonData: products[x])
                yo.append(y)
            }
            
            productCat.products = yo
            // testing API
            productCat.catDetails = catDetail

            productCatArray.append(productCat)
            
        }
        return productCatArray
    }
    
    
    func getJsonCategoriesData(json : JSON) -> [GetAllCategoriesModel] {
        var productCatArray = [GetAllCategoriesModel]()
        for i in 0..<json.count {
            let data = json[i]
            let productCat = GetAllCategoriesModel(jsonData: data)
//            print(data)
            let childs = data["child"]
            var childsArray = [GetAllCategoriesChildModel]()
            for x in 0..<childs.count {
                let childData = childs[x]
                let childClass = GetAllCategoriesChildModel(jsonData: childData)
                childsArray.append(childClass)
//                print(childData )
            }
            productCat.child = childsArray
            productCatArray.append(productCat)
        }
//        print(productCatArray   )
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
        if let imageData = NSData(contentsOf: imageURL!) , let img = UIImage(data: imageData as Data){
            return img 
        }
        return #imageLiteral(resourceName: "PlaceHolder")
        
    }
    
}//class



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
