//
//  HomePageM.swift
//  HyperApp
//
//  Created by Killvak on 26/12/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



class HomePage  {
    
    var _catName : String?
    
    var catName : String {
        guard _catName == nil else { return ""}
        return _catName!
    }
    var products : [ProductsM]?
    
}

class ProductsM  {
    
    
}

