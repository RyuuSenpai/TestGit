//
//  ViewController.swift
//  HyperApp
//
//  Created by Killvak on 09/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn
class LoginVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations on signed in user here.
        let userId = user.userID
        let idToken = user.authentication.idToken
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        let userImage = user.profile.imageURL(withDimension: 400)
        print("idToken :\(idToken)")
        print("fullName :\(fullName)")
        print("givenName :\(givenName)")
        print("familyName :\(familyName)")
        print("email :\(email)")
        print("userId :\(userId)")
        print("userImage :\(userImage)")

        
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        print("A7a el wala tel3 wala  eah")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
/*
        GIDSignIn.sharedInstance().signInSilently()
*/
        GIDSignIn.sharedInstance().signOut()

        
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        
        if configureError != nil {
            print(configureError)
        }
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
//        let button = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        button.center = view.center
//        
//        view.addSubview(button)
     
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignupVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func googleSignIn(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signIn()
        /*
         GIDSignIn.sharedInstance().signOut()
 */
    }


}

