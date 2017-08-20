//
//  GetItemReviewModel.swift
//  HyperApp
//
//  Created by Killvak on 06/01/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetItemReviewModel {
    
    private  var _dateAdd : String?
    var productDetails : ProductDetails?
    private  var _rate : Double?
    private  var _id : Int?
    private  var _review : String?
    private  var _active : Bool?
    private  var _dateUpd : String?
    var userData : UserDataModel?

    var dateAdd : String {
        guard let dateAdd_ = _dateAdd else { return ""  }
        return dateAdd_
    }
    var rate : Double {
        guard let rate_ = _rate else { return 0 }
        return rate_
    }
   
    var id : Int {
        guard let id_ = _id else { return 0  }
        return id_
    }
    
    var review : String {
        guard let review_ = _review else { return ""  }
        return review_
    }
    var active : Bool {
        guard let active_ = _active else { return false  }
        return active_
    }
  
    var dateUpd : String {
        guard let dateUpd_ = _dateUpd else { return ""  }
        return dateUpd_
    }
    init(jsonData : JSON) {
        
        self._dateAdd = jsonData["date_add"].stringValue
        self._rate = jsonData["rate"].doubleValue
        self._review = jsonData["review"].stringValue
        self._active = jsonData["active"].boolValue
        self._id = jsonData["id"].intValue
        self._dateUpd = jsonData["date_upd"].stringValue
    }
    init() {
        
    }
    
}


class UserDataModel {
    
    private  var _id : Int?
    private  var _email : String?
    private  var _fullName : String?
    private  var _firstName : String?
    private  var _lastName : String?

    var id : Int {
         guard let id_ = _id else { return 0  }
        return id_
    }
    var email : String {
        guard let email_ = _email else { return ""  }
        return email_
    }
    var firstName : String {
         guard let firstName_ = _firstName else { return ""  }
        return firstName_
    }
    var lastName : String {
         guard let lastName_ = _lastName else { return ""  }
        return lastName_
    }
    var fullname : String {
        return firstName + " " + lastName
    }
    
    init(jsonData : JSON) {
        self._firstName = jsonData["first_name"].stringValue
        self._lastName = jsonData["last_name"].stringValue
        self._email = jsonData["email"].stringValue
        self._id = jsonData["id"].intValue
    }
    init() {
        
    }
    
}







class GetAllBrandsModel {
    
    private  var _nameAr : String?
    private  var _image : String?
    private  var _id : Int?
    
 
    
    var nameAr : String {
        guard let x = _nameAr else { return ""  }
        return x
    }
    var image : String {
        guard let x = _image else { return ""  }
        return x
    }
    var id : Int {
        guard let x = _id else { return 0  }
        return x
    }
    
    init(jsonData : JSON) {
        self._nameAr = jsonData["nameAr"].stringValue
        self._image = jsonData["image"].stringValue
        self._id = jsonData["id"].intValue
     }
    init() {
        
    }
    
}





