//
//  User_LocationModel.swift
//  HyperApp
//
//  Created by Killvak on 08/07/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class User_LocationModel{
    
    
    func postUserAddress(userID : String    ,completed : @escaping () -> ()) {
        let parameters : Parameters = ["user_id" : userID ]
        
        
        CONFIGURATION.timeoutIntervalForResource = 10 // seconds
        print("that is the postUserAddress parameters : \(parameters)")

//        let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
        
        Alamofire.request(BASE_URL + GET_USER_ADDRESS , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
            print("that is the postUserAddress url  : \(BASE_URL + GET_USER_ADDRESS)")

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
    
    ///user_id, floor_num, building_num, street_name, longitude, latitude, (description)
    
    
    func postAddingUserAddress(user_id : String , floor_num: String? , building_num : String?, street_name : String, longitude : Double?, latitude : Double?  ,completed : @escaping () -> ()) {
        let parameters : Parameters = ["user_id" : user_id, "floor_num" : floor_num ?? "", "building_num" : building_num ?? "", "street_name" : street_name , "longitude" : longitude ?? 0.0, "latitude" : latitude ?? 0.0 ]
        print("that is the parameters in postAddingUserAddress : \(parameters)")
        
        
        CONFIGURATION.timeoutIntervalForResource = 10 // seconds
        
        //        let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
        
        Alamofire.request(BASE_URL + Get_ADD_ADDRESS , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                guard let data = response.result.value else { print(" postAddingUserAddress data returbn == NULL") ; return }
                let json = JSON(data)
                print("postAddingUserAddress L : \(json)")
                completed()
                break
                
            case .failure(let err as NSError):
                print("that is the error Descriptio0n : \(err.description)")
                completed()
                break
            default :
                print("Erro in postAddingUserAddress State   ")
                completed()
            }
        }
    }
    
    
    
     }
