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
import CoreData
class LoginVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate  , FBSDKLoginButtonDelegate {
    
    
    let userMail = ""
    let userID = ""

    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations on signed in user here.
        guard user != nil else {
            return
        }
        guard let id = user.userID , let email = user.profile.email else {  return
            UserDefaults.standard.setValue(nil, forKey: "userID")

        }
        print("userId :\(id)")
        print("email :\(email)")
        
        UserDefaults.standard.setValue(id, forKey: "userID")
        /*
        let idToken = user.authentication.idToken
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let userImage = user.profile.imageURL(withDimension: 400)
        print("idToken :\(idToken)")
        print("fullName :\(fullName)")
        print("givenName :\(givenName)")
        print("familyName :\(familyName)")
        print("userImage :\(userImage)")
*/
        
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
        

//        GIDSignIn.sharedInstance().signOut()

        
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
        showFbEmailAddress()
    }
    
    @IBAction func fbLoginBtnAct(_ sender: AnyObject) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, err ) in
            if err != nil {
                print("Custom FB Login failed",err)
                return
            }
//            print(result?.token.tokenString)
            self.showFbEmailAddress()
        }
    }
    
    @IBAction func TestSignOut(_ sender: AnyObject) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
            GIDSignIn.sharedInstance().signOut()

        UserDefaults.standard.setValue(nil, forKey: "userID")

    }
    func showFbEmailAddress(){
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id, name, email,first_name,last_name,picture"]).start { (connection, result, err) in
            
            if err != nil {
                print("failed to start graph request :  ",err)
            }
            print(result)
            /*
             var userID = user["id"] as NSString
             var facebookProfileUrl = "http://graph.facebook.com/\(userID)/picture?type=large"
 */
            
        }
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
    

    @IBAction func dismissView(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

}

