//
//  GetImagesFromWeb.swift
//  HyperApp
//
//  Created by Killvak on 08/04/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import AlamofireImage
import Alamofire

class GetImagesFromWeb {

    static   func getImageProductDetails(  productDetails : inout [ProductDetails]?) {
        for pd in productDetails! {
            guard let imgStrUrl = pd.image_url else {return }
            Alamofire.request(imgStrUrl).responseImage { response in
                debugPrint(response)
                
                print(response.request)
                print(response.response)
                debugPrint(response.result)
                
                if let image = response.result.value {
//                    print("image downloaded: \(image)")
                pd.image_pr = image
                }
            }
        }

        
        
    }






}
