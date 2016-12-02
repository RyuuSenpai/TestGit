//
//  HPCartNumberPadge.swift
//  HyperApp
//
//  Created by Killvak on 30/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import RealmSwift

extension HomePageVC {
    
    func upDateItemInCart() {
        do {
            let realm = try Realm()
            let cartL = realm.objects(CDOnCart.self)
            self.itemsInCart = cartL.count
        }catch let err as NSError {
            print("that is error in upDateItemInCart   :   \(err)")
        }
        
    }}
