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
    
    
    func downloadImage(favItem : CDFavList?, completionHandler handler: @escaping (_ imageData : Data) -> Void) {
        guard let items = favItem else { return }
        let url = URL(string: items.image_URL)
        DispatchQueue.global(qos: .userInitiated).async {
            () -> Void in
            
            let imgData = try? Data(contentsOf: url!)
            
            DispatchQueue.main.async(execute: {
                () -> Void in
                handler(imgData!)
            })
        }
    }
    
    
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