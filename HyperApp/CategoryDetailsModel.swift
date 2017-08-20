//
//  CategoryDetailsModel.swift
//  HyperApp
//
//  Created by Killvak on 05/01/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import SwiftyJSON


class CategoryDetailsModel {
    
    private  var _dateAdd : String?
    private  var _name : String?
    private  var _dateUpd : String?
    private  var _code : String?
    private  var _active : Bool?
    private  var _id : Int?
//    private  var _imageUrl : String?

    var dateAdd : String {
        guard let dateAdd_ = _dateAdd else { return ""  }
        return dateAdd_
    }
    var name : String {
        guard let name_ = _name else { return ""  }
        return name_
    }
    var dateUpd : String {
        guard let dateUpd_ = _dateUpd else { return ""  }
        return dateUpd_
    }
    var code : String {
        guard let code_ = _code else { return ""  }
        return code_
    }
    var active : Bool {
        guard let active_ = _active else { return false  }
        return active_
    }
    var id : Int {
        guard let id_ = _id else { return 0  }
        return id_
    }
//    var image : String {
//        print("that's the imageURL : \(_imageUrl)")
//        guard let x = _imageUrl else { return "" }
//        return   IMAGE_HOME_PATH + "/" + x
//    }
    init(jsonData : JSON) {
        
        self._dateAdd = jsonData["date_add"].stringValue
        self._name = jsonData["name"].stringValue
        self._dateUpd = jsonData["date_upd"].stringValue
        self._code = jsonData["code"].stringValue
        self._active = jsonData["active"].boolValue
        self._id = jsonData["id"].intValue
//        self._imageUrl = jsonData["image"].stringValue

    }
    
   
    
    
    
    
    
}
