//
//  SearchModel.swift
//  HyperApp
//
//  Created by Killvak on 16/06/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import SwiftyJSON

class Search_Data {
    
    private var _reduction_from : String?
    private var _main_material : String?
    private var _price : Double?
    private var _box_content_ar : String?
    private var _new_code : String?
    private var _main_color : String?
    private var _descriptionAr : String?
    private var _id_main_color : String?
    private var _id : Int?
    private var _code : String?
    private var _reduction_to : String?
    private var _description : String?
    private var _weight : String?
    private var _date_add : String?

    private var _name : String?
    private var _id_supplier : Int?
    private var _box_content : String?
    private var _warranty : String?
    private var _main_category : String?
    private var _category : String?
    private var _id_category  : Int?
    private var _highlights : String?
    private var _id_manufacturer : Int?
    private var _highlightsAr : String?
    
    private var _dimensions : String?
    private var _main_image : String?
    private var _quantity : Int?
    private var _nameAr : String?
    private var _date_upd : String?
    private var _out_of_stock : String?
    private var _reduction_price  : Int?
    private var _reduction_percent : Double?
    private var _on_sale : Int?
    private var _wholesale_price : String?
    
    private var _country  : String?
    private var _id_main_category : Int?
    
    
    
    var name : String {
        guard let x = _name else {    return ""  }
            return x
    }
    
    var price : Double {
        guard let x = _price else { return 0 }
        return x
    }
    
    var image : String {
        guard let x = _main_image else { return "" }
        return   IMAGE_HOME_PATH + "/" + x
    }
    
    var id : Int {
        guard let x = _id else {   return 0      }
        return x
    }
    
    init(_ json : JSON ) {
        
        self._main_image = json["main_image"].stringValue
        self._name = json["name"].stringValue
        self._nameAr = json["nameAr"].stringValue
        self._price = json["price"].doubleValue
        self._id = json["id"].intValue
    }
    
    
    
    
  }


















