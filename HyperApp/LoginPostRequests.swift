//
//  LoginPostRequests.swift
//  HyperApp
//
//  Created by Killvak on 06/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginPostRequests {
    
    func postLogInRequest(email : String , password : String ,completed : @escaping (String?) -> ()) {
        let parameters : Parameters = ["email" : email , "password" : password ]
        print("that is the parameters in Get_ItemById : \(parameters)")
        
        
        CONFIGURATION.timeoutIntervalForResource = 10 // seconds
        let query_url = BASE_URL + SIGN_IN
        let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
        print("that is the queryUrl for Signin : ", query_url )
        
        Alamofire.request( query_url , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                guard let data = response.result.value else { print(" ProductDetails data returbn == NULL") ; return }
                let json = JSON(data)
                print("Killva: that is the response value from SignIn  : " , response.result.value)
                completed(json["response"].stringValue)
                break
                
            case .failure(let err as NSError):
                print(response.result.error)
                print(response)
                print(response.request)
                
                print("that is the error Descriptio0n : \(err.description)")
                completed(nil)
                break
            default :
                print("Erro in Switch State Ment in getItem by ID Default was Selected")
                completed(nil)
            }
        }
    }
    
    
    func fbLoginPostRequest(firstName: String , lastName : String ,ImageUrl : String , email : String? , birthday: String? , gender : String? , Token : String , id : String ,completion: @escaping (Bool,String?) -> ()){
    
         let parameters : Parameters = [
            "first_name" :  firstName , "last_name" : lastName , "picture" : ImageUrl , "email" : email ?? "", "birthday" : birthday , "gender" : gender  , "fb_token" : Token , "id" : id ]
        print("that is the fbloggin parameters \(parameters)")
        let query_url = BASE_URL + FACEBOOK_LOGIN

        Alamofire.request( query_url , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                guard let data = response.result.value else { print(" ProductDetails data returbn == NULL") ; return }
                let json = JSON(data)
                print("Killva: that is the response value from fbSignIn  : " , response.result.value)
                completion(true,json["response"].stringValue)
                break
                
            case .failure(let err as NSError):
//                print(response.result.error)
//                print(response)
//                print(response.request)
                
                print("that is the error Descriptio0n : \(err.localizedDescription)")
                completion(false,nil)
                break
            default :
                print("Erro in Switch State Ment in getItem by ID Default was Selected")
                completion(false,nil)
            }
        }
        
        
        
    }
 
    func googleLoginPostRequest(firstName: String , lastName : String ,ImageUrl : String , email : String? , birthday: String? , gender : String? , Token : String,completion: @escaping (Bool,String?) -> ()){
        
        let parameters : Parameters = [
            "first_name" :  firstName , "last_name" : lastName , "picture" : ImageUrl , "email" : email ?? "", "birthday" : birthday ?? "" , "gender" : gender ?? "" , "google_id" : Token  ]
        print("that is the googleLoginPostRequest parameters \(parameters)")
        let query_url = BASE_URL + GOOGLE_LOGIN
        
        Alamofire.request( query_url , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                guard let data = response.result.value else { print(" ProductDetails data returbn == NULL") ; return }
                let json = JSON(data)
                print("Killva: that is the response value from googleLoginPostRequest  : " , response.result.value)
                completion(true,json["response"].stringValue)
                break
                
            case .failure(let err as NSError):
//                print(response.result.error)
//                print(response)
//                print(response.request)
                
                print("that is the error Descriptio0n : \(err.localizedDescription)")
                completion(false,nil)
                break
            default :
                print("Erro in Switch State Ment in getItem by ID Default was Selected")
                completion(false,nil)
            }
        }
        
        
        
    }
}
