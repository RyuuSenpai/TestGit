//
//  Constants.swift
//  HyperApp
//
//  Created by Killvak on 14/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation


typealias DownloadCompelete = () -> ()

//let BASE_URL = "http://hyper-techno-stage.herokuapp.com/"
let BASE_URL  = "http://hyper-testing.herokuapp.com/"
let HOME_PAGE = "HomePage"
let HEADER_ID = "Authorization"
let HEADER_PASSWORD = "627562626c6520617069206b6579"
let GET_ITEM = "GetItem"
let GET_ITEM_BY_CAT = "GetItemByCategory"
let SIGNUP_API  = "signup"
let GET_ITEM_REVIEW = "GetItemReview"
let ADD_REVIEW = "AddReview"
let GET_ALL_CATEGORIES = "GetAllCategories"
let POST_MAKE_ORDER = "makeOrder"

  let IMAGE_HOME_PATH = "http://arafa.host56.com/Hyper/uploads/i"
//let IMAGE_HOME_PATH = "http://bubble.zeowls.com/uploads/"
let REFRESH_HOMEPAGE_CELLS = NSNotification.Name("RefreshHPNotification")
let UPDATE_CART_BADGE = NSNotification.Name("UPDATE_CART_BADGE")
let REFRESH_PRODUCT_DETAILS_ICONS = NSNotification.Name("REFRESH_PRODUCT_DETAILS_ICONS")
let HEADER   = [HEADER_ID : HEADER_PASSWORD]

let CONFIGURATION = URLSessionConfiguration.default

let green = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
let red = UIColor(red: 1, green: 0, blue: 0, alpha: 1)

func setOutLetsTitle(arabicTitle : String , engTitle:String ) -> String{
    if L102Language.currentAppleLanguage() == "ar" {
        return arabicTitle
    }else {
      return engTitle
    }
}

extension UINavigationController {

    func setColor() {
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
}

