//
//  SHA256Signup.swift
//  HyperApp
//
//  Created by Killvak on 09/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation

extension SignupVC {
    
    func sha256(string: String) -> Data? {
        guard let messageData = string.data(using:String.Encoding.utf8) else { return nil; }
        var digestData = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_SHA256(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        return digestData
    }
    
    
    
//    let testString = "sha me"
//    print("testString: \(testString)")
//    let shaData = sha256(string: testString)
//    let shaHex = shaData!.map { String(format: "%02hhx", $0) }.joined()
//    print("shaHex: \(shaHex)")
}
