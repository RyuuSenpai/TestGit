//
//  MyPlayGround.swift
//  HyperApp
//
//  Created by Killvak on 26/12/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
//: Playground - noun: a place where people can play

import UIKit
import Alamofire
import SwiftyJSON
var str = "Hello, playground"

//    test
//func getTheData( compeleted: @escaping ([ProductCategories]) -> ()){
//
//    let query_url = BASE_URL + HOME_PAGE
//
//    // escape your URL
//    let urlAddressEscaped = query_url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
//
//
//    //Request with caching policy
//    let request = URLRequest(url: URL(string: urlAddressEscaped!)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 20)
//
//    Alamofire.request( request).authenticate(user: HEADER_ID, password: HEADER_PASSWORD)
//        .responseJSON { (response) in
//
//            switch(response.result) {
//            case .success(_):
//                print("Success")
//                URLCache.shared.removeAllCachedResponses()
//                let cachedURLResponse = CachedURLResponse(response: response.response!, data: (response.data! as NSData) as Data, userInfo: nil, storagePolicy: .allowed)
//                URLCache.shared.storeCachedResponse(cachedURLResponse, for: response.request!)
//
//                let json = JSON(data: cachedURLResponse.data)
//
//
//                break
//            case .failure(let err as NSError) :
//                print("that is fail i n getting the data Mate : %@",err.debugDescription)
//                if let urlRequest = request.urlRequest {
//                    let x = URLCache.shared.cachedResponse(for: urlRequest)
//                    let json = JSON(data: (x?.data)!) // SwiftyJSON
//                    //
//                    print(json) // Test if it works
//                }
//                break
//            default :
//                print("Problem getting the data Switch eeror ")
//            }
//            //                let json = JSON(data: cachedURLResponse.data) // SwiftyJSON
//            //                //
//            //                print(json) // Test if it works
//            //                guard response.result.error == nil else {
//            //
//            //                    // got an error in getting the data, need to handle it
//            //                    print("error fetching data from url")
//            //                    print(response.result.error!)
//            //                    return
//            //
//            //                }
//
//            //                 URLCache.shared.removeAllCachedResponses()
//            //                // do whatever you want with your data here
//            //                let json2 = JSON(data: cachedURLResponse.data) // SwiftyJSON
//            //                //
//            //                print(json2) // Test if it works
//    }
//}




/*
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
 //                           let imageUrl  = IMAGE_HOME_PATH + "/" + main_image
 //                            productDetail.image_pr = self.getImage(image: imageUrl)
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



