//
//  HomeData.swift
//  HyperApp
//
//  Created by Killvak on 13/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation

class HomeData  {
    
    private var _name : String!
    private var _title : String!
    private var _id : Int!
    
    var name : String {
        return _name
    }
    var title :String {
        return _title
    }
    var id : Int {
        return _id
    }
    
    init(name : String , title : String , id : Int   ) {

        _name = name
        _title = title
        _id = id
    }
    
    
    
}
