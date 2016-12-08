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
    
    func cartBtnAct(sender: UIButton , data : productDetails?,buyNow : Bool) {
        
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
    
    func saveCartData(data : productDetails? ,state : Bool? ) -> Bool  {
        let onCart = CDOnCart()
        guard let name = data?.name , let price = data?.price , let imgString = data?.image_url else { print("name in CDOnCart = nil "); return false  }
        onCart.name = name
        onCart.price = price
        onCart.imgString = imgString
        
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
