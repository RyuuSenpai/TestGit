//
//  Convertor.swift
//  HyperApp
//
//  Created by Killvak on 03/01/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import UIKit


class Convertor  {
    
    
    
    func FavListToProductList(data:CDFavList)->  ProductDetails? {
        
        let x = ProductDetails()
        x.name = data.name
        x.price = data.price
        x.id = data.id
        return x
    }
    
    
    func CartListToProductList(data:CDFavList)->  ProductDetails? {
        
        let x = ProductDetails()
        x.name = data.name
        x.price = data.price
        x.id = data.id
        return x
    }
    
    

    
}
