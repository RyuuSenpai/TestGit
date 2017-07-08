//
//  OnCartFunctionality.swift
//  HyperApp
//
//  Created by Killvak on 01/12/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import RealmSwift

class OnCartFunctionality {
    func cartBtnAct(sender: UIButton , data : CartDetails?,buyNow : Bool) {
//        let obj = transferDataToCartObj(data: data)
        sender.isSelected = !sender.isSelected
        if buyNow {
            saveCartData(data: data, state: true )
        }else {
            if sender.isSelected == true {
                sender.setImage(UIImage(named:"carticon"), for: UIControlState.normal)
                saveCartData(data: data, state: true )
            }else {
                sender.setImage(UIImage(named:"cart"), for: UIControlState.normal)
                
                saveCartData(data: data, state: false )
                
            }
            NotificationCenter.default.post(name: UPDATE_CART_BADGE , object: nil)
        }
        
        
    }
    
    func cartCDBtnAct(sender: UIButton , data : CDFavList?,buyNow : Bool) {
        let obj = transCDfavDataToCartObj(data: data)
        sender.isSelected = !sender.isSelected
        if buyNow {
            saveCartData(data: obj, state: true )
        }else {
            if sender.isSelected == true {
                sender.setBackgroundImage(UIImage(named:"carticon"), for: UIControlState.normal)
                saveCartData(data: obj, state: true )
            }else {
                sender.setBackgroundImage(UIImage(named:"cart"), for: UIControlState.normal)
                
                saveCartData(data: obj, state: false )
                
            }
            NotificationCenter.default.post(name: UPDATE_CART_BADGE , object: nil)
        }
        
        
    }
    
    func transferDataToCartObj(data: ProductDetails?) -> CartDetails?{
        let obj = CartDetails()
        obj.name = data?.name
        obj.price = data?.price
        obj.image_url = data?.image_url
        obj.id = data?.id
//        print(obj.name)
//        print(obj.price)
//        print(obj.image_url)
        return obj
    }
    
    func transCDfavDataToCartObj(data: CDFavList?) -> CartDetails?{
        let obj = CartDetails()
        obj.name = data?.name
        obj.price = data?.price
        obj.image_url = data?.image_url
        obj.id = data?.id
//        print(obj.name)
//        print(obj.price)
//        print(obj.id)
        return obj
    }
    
    func transSearch_DataToCartObj(data: Search_Data?) -> CartDetails?{
        let obj = CartDetails()
        obj.name = data?.name
        obj.price = data?.price
        obj.image_url = data?.image
        obj.id = data?.id
        //        print(obj.name)
        //        print(obj.price)
        //        print(obj.id)
        return obj
    }
    
    func saveCartData(data : CartDetails? ,state : Bool? ) -> Bool  {
        let onCart = CDOnCart()
        guard let name = data?.name , let price = data?.price , let id = data?.id  , let imgString = data?.image_url else { print("name in CDOnCart = nil "); return false  }
        onCart.name = name
        onCart.price = price
        onCart.imgString = imgString
        onCart.id = id

        do {
            
            let realm = try Realm()
            
            if  let item = realm.object(ofType: CDOnCart.self, forPrimaryKey: onCart.name)  {
                print("Dublicated data right there saveCartData ")
                if let stateOf = state , stateOf == false  {
                    print("will delete : \(item)")
                    realm.beginWrite()
                    realm.delete(item)
                    try  realm.commitWrite()
                    return false
                }
                return true
            }else if let stateOf = state , stateOf == true  {
                try realm.write{
                    realm.add(onCart)
                    print("that Saved ya Man \(onCart.name) and price \(onCart.price)")
                }}
        }catch let err as NSError {
            print(" saveCartData that is error :    \(err)")
        }
        return false
    }
    
}

class CartDetails : NSObject {
    
    var id : Int?
    var name :String?
    var image_url : String?
    var image_pr :UIImage?
    var id_parent : NSNumber?
    var level_depth : NSNumber?
    var price  : Double?
    var preDiscountPrice : NSNumber?
    var isFav : Bool?
    var onCart : Bool?
    var prDescription : String?
    
}
