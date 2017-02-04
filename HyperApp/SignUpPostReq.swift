//
//  SignUpPostReq.swift
//  HyperApp
//
//  Created by Killvak on 05/01/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class SignUpPostReq {
    
    func postSignupData(firstName : String , lastName: String , password : String , email : String , birthDay : String , gender : String  ,completed : @escaping (ProductDetails?) -> ()) {
    let parameters : Parameters = ["first_name" : firstName, "last_name" : lastName , "password" : password, "email" : email , "gender" : gender , "birthday":birthDay]
    print("that is the parameters in postSignupData : \(parameters)")
    
    
    CONFIGURATION.timeoutIntervalForResource = 10 // seconds
    
    let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
    
    Alamofire.request(BASE_URL + SIGNUP_API , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
        
        switch(response.result) {
        case .success(_):
            guard let data = response.result.value else { print(" ProductDetails data returbn == NULL") ; return }
            let json = JSON(data)
            print("Killva: that is the response value from Signup  : " , response.result.value)
            break
            
        case .failure(let err as NSError):
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
