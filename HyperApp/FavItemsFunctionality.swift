//
//  FavItemsFunctionality.swift
//  HyperApp
//
//  Created by Killvak on 01/12/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import RealmSwift
class FavItemsFunctionality  {
    
    func FavBtnAct(sender:UIButton,data:productDetails?) {
        
        print("that is the button index : \(sender.tag)")
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            sender.setBackgroundImage(UIImage(named:"heart_icon_selected"), for: UIControlState.normal)
            saveFavData(data: data, state: true)
        }else {
            sender.setBackgroundImage(UIImage(named:"Heart_icon"), for: UIControlState.normal)
            saveFavData(data: data, state: false)
        }
        
        
    }
    
    
    
    func saveFavData(data : productDetails? ,state : Bool?  ) -> Bool {
        let fav = CDFavList()
        
        guard let name = data?.name , let price = data?.price , let imgString = data?.image_url else { print("name in CDFavList = nil "); return false  }
        fav.name = name
        fav.price = price
        fav.image_url = imgString
        do {
            
            let realm = try Realm()
            
            if  let item = realm.object(ofType: CDFavList.self, forPrimaryKey: fav.name)  {
                print("Dublicated data right there saveFavData ")
                if let stateOf = state , stateOf == false  {
                    print("will delete : \(item)")
                    realm.beginWrite()
                    realm.delete(item)
                    try  realm.commitWrite()
                    return false
                }
                return true
            }else if let stateOf = state , stateOf == true   {
                
                try realm.write{
                    realm.add(fav)
                    print("that Saved ya Man \(fav.name)")
                }}
        }catch let err as NSError {
            print("saveFavData that is error :    \(err)")
            return false
        }
        return false
    }
    
}
