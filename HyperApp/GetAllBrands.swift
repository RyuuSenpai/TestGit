//
//  GetAllBrands.swift
//  HyperApp
//
//  Created by Killvak on 02/04/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class GetAllBrands {
    
    
    
    
    
    func getAllBrands( pageNum : Int ,compeleted: @escaping () -> ()){
        //        let query_url = BASE_URL + GET_ALL_CATEGORIES
        var query_url : String!
        if pageNum == 1 {
            query_url = BASE_URL + GET_ALL_BRANDS
            
        }else {
            query_url = BASE_URL + GET_ALL_BRANDS + "\(2)"
        }
        
//        print("getAllBrands Url link : " ,query_url)
//        let request = alamoRequest(query_url: query_url)
        
        
        Alamofire.request(query_url, headers: HEADER).responseJSON { (response) in
            switch(response.result) {
            case .success(_):
//                print("Success")
                //                        URLCache.shared.removeAllCachedResponses()
                let cachedURLResponse = CachedURLResponse(response: response.response!, data: (response.data! as NSData) as Data, userInfo: nil, storagePolicy: .allowed)
                URLCache.shared.storeCachedResponse(cachedURLResponse, for: response.request!)
                
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
//                    print("error fetching data from url")
//                    print(response.result.error!)
                    return
                }
//                print("Killva: That is getAllCategories response :  " , response.result.value )
//                let json = JSON(data: cachedURLResponse.data) // SwiftyJSON
//                let productCatArray =  self.getJsonCategoriesData(json: json)
                
                compeleted()
                break
            case .failure(let err as NSError) :
//                print("Killva: that is response :  \(response.result.debugDescription) and that is the error withgetting the data Mate : %@",err.localizedDescription)
//                if let urlRequest = request.urlRequest {
//                    let x = URLCache.shared.cachedResponse(for: urlRequest)
//                    guard let cache = x else {
//                        compeleted([])
//                        return
//                    }
//                    let json = JSON(data: cache.data) // SwiftyJSON
//                    //
//                    let productCatArray =  self.getJsonCategoriesData(json: json)
//                    
                    compeleted()
//                }
                
                break
            default : break 
//                print("Problem getting the data Switch eeror ")
            }
            
        }
        
    }
    

}
