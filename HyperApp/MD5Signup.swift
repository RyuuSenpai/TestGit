//
//  MD5Signup.swift
//  HyperApp
//
//  Created by Killvak on 09/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation

//extension SignupVC {
//    
//    func MD5(string: String) -> Data? {
//        guard let messageData = string.data(using:String.Encoding.utf8) else { return nil }
//        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
//        
//        _ = digestData.withUnsafeMutableBytes {digestBytes in
//            messageData.withUnsafeBytes {messageBytes in
//                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
//            }
//        }
//        
//        return digestData
//    }
//    
//    //Test:
////    let md5Data = MD5(string:"Hello")
////    let md5Hex =  md5Data!.map { String(format: "%02hhx", $0) }.joined()
////    print("md5Hex: \(md5Hex)")
//    
//}
