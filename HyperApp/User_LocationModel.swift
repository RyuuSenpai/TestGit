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
    
    
    func postUserAddress(userID : String,completed : @escaping ([LocationData]?) -> ()) {
        let parameters : Parameters = ["user_id" : userID ]
        
        
        CONFIGURATION.timeoutIntervalForResource = 10 // seconds
//        print("that is the postUserAddress parameters : \(parameters)")

//        let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
        
        Alamofire.request(BASE_URL + GET_USER_ADDRESS , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
//            print("that is the postUserAddress url  : \(BASE_URL + GET_USER_ADDRESS)")

            switch(response.result) {
            case .success(_):
                guard let data = response.result.value else { print(" ProductDetails data returbn == NULL") ; return }
                let json = JSON(data)
                
             var locationArray = [LocationData]()
                
                for ( _ , value) in json {
                    let x = LocationData(value)
                    locationArray.append(x)
                }
//                print(json)
                completed(locationArray)
                break
                
            case .failure(let err as NSError):
//                print("that is the error Descriptio0n : \(err.description)")
                completed(nil)
                break
            default :
//                print("Erro in Switch State Ment in getItem by ID Default was Selected")
                completed(nil)
            }
        }
    }
    
    ///user_id, floor_num, building_num, street_name, longitude, latitude, (description)
    
    
    func postAddingUserAddress(user_id : String , floor_num: String? , building_num : String?, street_name : String, longitude : Double?, latitude : Double?  ,completed : @escaping () -> ()) {
        let parameters : Parameters = ["user_id" : user_id, "floor_num" : floor_num ?? "", "building_num" : building_num ?? "", "street_name" : street_name , "longitude" : longitude ?? 0.0, "latitude" : latitude ?? 0.0 ]
//        print("that is the parameters in postAddingUserAddress : \(parameters)")
        
        
        CONFIGURATION.timeoutIntervalForResource = 10 // seconds
        
        //        let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
        
        Alamofire.request(BASE_URL + Get_ADD_ADDRESS , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                guard let data = response.result.value else { print(" postAddingUserAddress data returbn == NULL") ; return }
                let json = JSON(data)
//                print("postAddingUserAddress L : \(json)")
                completed()
                break
                
            case .failure(let err as NSError):
//                print("that is the error Descriptio0n : \(err.description)")
                completed()
                break
            default :
//                print("Erro in postAddingUserAddress State   ")
                completed()
            }
        }
    }
    
    
    
     }




class LocationData {
    
    private var _dateAdded : String?
    private var _actice : Bool?
    private var _floorNum : Int?
    private var _id : Int?
    private var _buildingNum : Int?
    private var _streetName : String?
    private var _desc : String?
    private var _dateUpd : String?
    private var _userID : Int?
    

    
    var floor : Int {
        guard let x = _floorNum else {   return 0      }
        return x
    }
    var address_ID : Int {
        guard let x = _id else {   return 0      }
        return x
    }
    var buildingNum : Int {
        guard let x = _buildingNum else {   return 0      }
        return x
    }
    var streetName : String {
        guard let x = _streetName else { return "" }
        return  x
    }
    var description : String {
        guard let x = _desc else { return "" }
        return    x
    }
    var user_ID : Int {
        guard let x = _userID else {   return 0      }
        return x
    }
    init(_ json : JSON ) {
        
        self._floorNum = json["floor_num"].intValue
        self._id = json["id"].intValue
        self._buildingNum = json["building_num"].intValue
        self._streetName = json["street_name"].stringValue
        self._desc = json["description"].stringValue
        self._id = json["id_user"].intValue
    }
    
    
    
    
}






