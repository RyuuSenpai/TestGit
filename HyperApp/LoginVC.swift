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
import FBSDKLoginKit

class LoginVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate  , FBSDKLoginButtonDelegate {
    
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations on signed in user here.
//        let userId = user.userID
//        let idToken = user.authentication.idToken
//        let fullName = user.profile.name
//        let givenName = user.profile.givenName
//        let familyName = user.profile.familyName
//        let email = user.profile.email
//        let userImage = user.profile.imageURL(withDimension: 400)
//        print("idToken :\(idToken)")
//        print("fullName :\(fullName)")
//        print("givenName :\(givenName)")
//        print("familyName :\(familyName)")
//        print("email :\(email)")
//        print("userId :\(userId)")
//        print("userImage :\(userImage)")

        
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        print(" el ")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
/*
        GIDSignIn.sharedInstance().signInSilently()
*/
        
        //Matk : - facebook Login
        let FBLoginButton = FBSDKLoginButton()
        view.addSubview(FBLoginButton)
                FBLoginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        FBLoginButton.delegate = self
        //@End FB
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
    
    
    //MARK : - Facebook deledate Protocoal 
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        print("Successfully logged in with facebook...")
    }
    
    //@End FB Delegate
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

