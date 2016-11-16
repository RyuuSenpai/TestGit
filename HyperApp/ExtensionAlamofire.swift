//
//  ExtensionAlamofire.swift
//  HyperApp
//
//  Created by Killvak on 15/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import Alamofire


//extension  FavListVC {
//    
//    func downloadHomePageData( compeleted: @escaping DownloadCompelete){
//        
//        let header   = [HEADER_ID : HEADER_PASSWORD]
//        Alamofire.request( BASE_URL + HOME_PAGE, headers: header)
//            .responseJSON { response in
//                
////                print(response.result)
//                
//                if let dict = response.result.value as? [Dictionary<String,AnyObject>] {
//                    
//                    for obj in dict {
////                        print(obj)
////                        print("-------------------")
//                        let fhp = FHP(dict: obj)
//                        self.almno.append(fhp)
//                        
//                    }//for
//                    
//                }//dict
//                compeleted()
//                
//        }
//    }
//    
//    
//}


class FHP : NSObject {
    var catName : String?
    var productsList : [SFHP]?
   
    func downloadHomePageData( compeleted: @escaping ([FHP]) -> ()){
        
        let header   = [HEADER_ID : HEADER_PASSWORD]
        Alamofire.request( BASE_URL + HOME_PAGE, headers: header)
            .responseJSON { response in
                
                //                print(response.result)
                var productCategories = [FHP]()
                if let dict = response.result.value as? [Dictionary<String,AnyObject>] {
                    
                    for obj in dict {
                        guard let name = obj["Catname"] as? String  ,  let products = obj["Products"] as? [Dictionary<String,AnyObject>]  else { print("returned from first loop in almo") ; return }
                        let cat = FHP()
                        var list = [SFHP]()
                        cat.catName = name
                        print(name)
                        for productobj in products {
                            guard let price = productobj["price"] as? String , let id = productobj["id"] as? Int else {print("returned from 2nd loop in almo") ; return }
                            let sfhp = SFHP()
                            sfhp.price = price
                            sfhp.id = id 
                            list.append(sfhp)
                        }//for
                        cat.productsList = list
                        productCategories.append(cat)
                      
                    }//for
                    
                }//dict
                compeleted(productCategories)
        }
}
}//class


class SFHP : NSObject {
    var price : String?
    var id : Int?
    var name : String?
    var quantity : String?
}
