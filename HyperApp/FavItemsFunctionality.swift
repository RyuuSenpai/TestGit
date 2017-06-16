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
    
    func FavBtnAct(sender:UIButton,_ name : String?, _ price : Double?,_ image : String?, _ id : Int?) {
        
        print("that is the button index : \(sender.tag)")
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            sender.setImage(UIImage(named:"heart_icon_selected"), for: UIControlState.normal)
             saveFavData(name, price, image, id , state: true)
        }else {
            sender.setImage(UIImage(named:"Heart_icon"), for: UIControlState.normal)
            saveFavData(name, price, image, id  , state: false )
        }
        
        
    }
    
    
    
    func saveFavData(_ _name : String?, _ _price : Double?,_ imgString : String?, _ _id : Int? ,state : Bool?  ) -> Bool {
        let fav = CDFavList()
        guard let name = _name , let price = _price  , let id =  _id  else {
            print(" saveFavData func passed a nil value : name : \(_name) , price : \(_price), id : \(_id) ");
            return false  }

         fav.name = name
        fav.price = price
        if let imgString = imgString {
        fav.image_url = imgString
        }
        fav.id = id
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
