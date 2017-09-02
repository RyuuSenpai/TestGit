//
//  PostRequestEx.swift
//  HyperApp
//
//  Created by Killvak on 29/08/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension PostRequests {
    
    
    
    
    func getOrdersList(completed : @escaping ([OrderList]?) -> ()) {
        let parameters : Parameters = ["user_id" : GLOBAL.USER_ID]
        //         print("that is the parameters in getBrandProductsDetailsData : \(parameters)")
        
        
        CONFIGURATION.timeoutIntervalForResource = 10 // seconds
        //        print("that is url getBrandProductsDetailsData By ID : \(BASE_URL + GET_ITEM_BY_BRAND)")
        //        let alamofireManager = Alamofire.SessionManager(configuration: CONFIGURATION)
        
        Alamofire.request(BASE_URL + GETOrdersByUser , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response:DataResponse<Any>) in
            print("that's the url : \(BASE_URL + GETOrdersByUser) and id : \(GLOBAL.USER_ID)")
            switch(response.result) {
            case .success(_):
                guard let data = response.result.value else { print(" getBrandProductsDetailsData data returbn == NULL") ; return }
                let json = JSON(data)
                                print(json)
                
                var productsDetails = [OrderList]()
                for(_, jsonn) in json{
                     let current_state = jsonn["current_state"]
                    let cart = jsonn["cart"]
                    
                    let productDetails = OrderList( jsonn)
                    //                if let imageUrl =  productDetails.image_url
                    //                {
                    //                    let productCat = ProductCategories()
                    //                    productDetails.image_pr = productCat.getImagee(image: imageUrl)
                    //                }
                    
                    
                    var orderCartList = [OrderCartList]()
                    for (_,json) in  cart {
                        let productDetails = OrderCartList( json)
                        orderCartList.append(productDetails)
                    }
                    let currentState = CurrentState(current_state)
                    productDetails.currentState = currentState
                    productDetails.orderCartList = orderCartList
                    productsDetails.append(productDetails)
                    
                    
                }
                completed(productsDetails)
                break
                
            case .failure(let err as NSError):
                //                print(response.result.error)
                //                print("that is the error getBrandProductsDetailsData : \(err.localizedDescription)")
                completed(nil)
                break
            default :
                //                print("Erro in Switch State Ment in getBrandProductsDetailsData by ID Default was Selected")
                completed(nil)
            }
        }
    }
}





class OrderList {
    
    private var _date_upd : String?
    private var _active : Int?
    private var _orderID : Int?
    private var _address : String?
    
    
    private var _date_add : String?
    
 
    var orderCartList : [OrderCartList]?
    
    var currentState : CurrentState?
    
    var date_upd : String {
        guard let x = _date_upd else {    return ""  }
        return x
    }
    
    var active : Bool {
        guard let x = _active , x == 0 else { return true }
        return false
    }
    
    var orderID : Int {
        guard let x = _orderID else { return 0 }
        return  x
    }
    
    var address : String {
        guard let x = _address else {   return ""      }
        return x
    }
    var date_add : String {
        guard let x = _date_add else {   return ""      }
        return x
    }
    
   
    init(_ json : JSON ) {
        
        self._date_upd = json["date_upd"].stringValue
        self._date_add = json["date_add"].stringValue
        self._orderID = json["id"].intValue
        self._address = json["address"].stringValue
        self._active = json["active"].intValue
        
    }
    
}


class OrderCartList {
    
    private var _product_name_ar : String?
    private var _product_image : String?
    private var _orderID : Int?
    private var _id : Int?
    private var _quantity : Int?
    private var _id_product : Int?
    private var _product_name : String?

    
    private var _active : Int?
    
    
    
//    var product_name_ar : String {
//        guard let x = _product_name_ar else {    return ""  }
//        return x
//    }
    
    var product_image : String {
        guard let x = _product_image else { return "" }
        return   IMAGE_HOME_PATH + "/" + x
    }
    var orderID : Int {
        guard let x = _orderID else { return 0 }
        return  x
    }
    var id : Int {
        guard let x = _id else {   return 0      }
        return x
    }
    
    var product_name : String {
        guard L102Language.currentAppleLanguage() == "ar" , let x = _product_name_ar else {
            guard let x = _product_name else {   return ""      }
            return x
        }
         return x
    }
    var quantity : Int {
        guard let x = _quantity else {   return 0      }
        return x
    }
    var id_product : Int {
        guard let x = _id_product else {   return 0      }
        return x
    }
    
    var active : Bool {
        guard let x = _active , x == 0 else { return true }
        return false
    }
    init(_ json : JSON ) {
        
        self._product_name_ar = json["product_name_ar"].stringValue
        self._product_image = json["product_image"].stringValue
        self._orderID = json["id_order"].intValue
        self._id = json["id"].intValue

        self._product_name = json["product_name"].stringValue
        self._quantity = json["quantity"].intValue
        self._id_product = json["id_product"].intValue

        self._active = json["active"].intValue
        
    }
    
}




class CurrentState {
    
    private var _date_upd : String?
    private var _active : Int?
    private var _iD : Int?
    private var _description : String?
    private var _name : String?

    
    private var _date_add : String?
    
    var orderCartList : [OrderCartList]?
    
    
    var date_upd : String {
        guard let x = _date_upd else {    return ""  }
        return x
    }
    
    var active : Bool {
        guard let x = _active , x == 0 else { return true }
        return false
    }
    
    var id : Int {
        guard let x = _iD else { return 0 }
        return  x
    }
    
    var description : String {
        guard let x = _description else {   return ""      }
        return x
    }
    var date_add : String {
        guard let x = _date_add else {   return ""      }
        return x
    }
    var name : String {
        guard let x = _name else {   return ""      }
        return x
    }
    init(_ json : JSON ) {
        self._name = json["name"].stringValue

        self._date_upd = json["date_upd"].stringValue
        self._date_add = json["date_add"].stringValue
        self._iD = json["id"].intValue
        self._description = json["description"].stringValue
        self._active = json["active"].intValue
        
    }
    
}



















