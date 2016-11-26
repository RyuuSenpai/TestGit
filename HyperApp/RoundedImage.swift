////
////  RoundedImage.swift
////  HyperApp
////
////  Created by Killvak on 08/11/2016.
////  Copyright © 2016 Killvak. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//
//extension UIImage {
//    var rounded: UIImage? {
//        let imageView = UIImageView(image: self)
//        imageView.layer.cornerRadius = min(size.height/4, size.width/4)
//        imageView.layer.masksToBounds = true
//        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
//        guard let context = UIGraphicsGetCurrentContext() else { return nil }
//        imageView.layer.render(in: context)
//        let result = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return result
//    }
//    var circle: UIImage? {
//        let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
//        let imageView = UIImageView(frame: CGRect(origin: .zero, size: square))
//        imageView.contentMode = .scaleAspectFill
//        imageView.image = self
//        imageView.layer.cornerRadius = square.width/2
//        imageView.layer.masksToBounds = true
//        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
//        guard let context = UIGraphicsGetCurrentContext() else { return nil }
//        imageView.layer.render(in: context)
//        let result = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return result
//    }
//}
//
////MARK : How to use it 
///*
// let profilePicture = UIImage(data: try! Data(contentsOf: URL(string:"http://i.stack.imgur.com/Xs4RX.jpg")!))!
// profilePicture.rounded
// profilePicture.circle
// 
// */
