//
//  GetImage.swift
//  HyperApp
//
//  Created by Killvak on 06/12/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import UIKit

class GetImage {
    
    func getFavListImages(data: CDFavList?,completed:@escaping(_ img : UIImage?) -> Void) {
        guard let data = data else {
            print("Found nill trying to get the image for getFavListImages")
            return
        }
        print("that is the image String : \(data.image_URL)")
        let imageUrl = URL(string: data.image_URL)
        DispatchQueue.global(qos: .userInteractive).async {
            () -> Void in
           
            guard let url = imageUrl , let imageData = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: imageData )
            
            DispatchQueue.main.async(execute: {
                completed(image)
                
            })
        }
    }
}
