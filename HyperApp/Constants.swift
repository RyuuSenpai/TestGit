//
//  Constants.swift
//  HyperApp
//
//  Created by Killvak on 14/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation


typealias DownloadCompelete = () -> ()

let BASE_URL = "http://hyper-techno-stage.herokuapp.com/"
let HOME_PAGE = "HomePage"
let HEADER_ID = "Authorization"
let HEADER_PASSWORD = "627562626c6520617069206b6579"


let IMAGE_HOME_PATH = "http://bubble.zeowls.com/uploads/"


let REFRESH_HOMEPAGE_CELLS = NSNotification.Name("RefreshHPNotification")
let UPDATE_CART_BADGE = NSNotification.Name("UPDATE_CART_BADGE")
let REFRESH_PRODUCT_DETAILS_ICONS = NSNotification.Name("REFRESH_PRODUCT_DETAILS_ICONS")
