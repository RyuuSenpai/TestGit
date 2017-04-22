//
//  PostReviewRequest.swift
//  HyperApp
//
//  Created by Killvak on 05/01/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class  PostReviewRequest {
    
    
    func getReviewRequesData(userID : Int , itemID: Int , rate : Float, reviewString : String  ,completed : @escaping () -> ()) {
        let parameters : Parameters = ["user_id" : userID, "item_id" : itemID , "rate" : rate, "review" : reviewString ]
        print("that is the parameters in getReviewRequesData : \(parameters)")
        
        
        CONFIGURATION.timeoutIntervalForResource = 10 // seconds
        
        let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
        
        Alamofire.request(BASE_URL + ADD_REVIEW , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                guard let data = response.result.value else { print(" ProductDetails data returbn == NULL") ; return }
                let json = JSON(data)
                print(json)
                completed()
                break
                
            case .failure(let err as NSError):
                print("that is the error Descriptio0n : \(err.description)")
                completed()
                break
            default :
                print("Erro in Switch State Ment in getItem by ID Default was Selected")
                completed()
            }
        }
    }
    
    
   
    
    
    func postReqMakeOrder(userID : String , items: [[String: Int]]   ,completed : @escaping () -> ()) {
////        let parameters : Parameters = ["user_id" : userID, "item_id" : itemID , "rate" : rate, "review" : reviewString ]
//        print("that is the parameters in getReviewRequesData : \(parameters)")
        
        let parameters: Parameters = [
            "user_id": userID,
            "items": items
        ]
        print(parameters)
        CONFIGURATION.timeoutIntervalForResource = 10 // seconds
        
        let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
        
        Alamofire.request(BASE_URL + POST_MAKE_ORDER , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                guard let data = response.result.value else { print(" ProductDetails data returbn == NULL") ; return }
                let json = JSON(data)
                print(json)
                completed()
                break
                
            case .failure(let err as NSError):
                print("that is the error Descriptio0n : \(err.description)")
                completed()
                break
            default :
                print("Erro in Switch State Ment in getItem by ID Default was Selected")
                completed()
            }
        }
    }
}
