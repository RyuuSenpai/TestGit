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
    
    @IBOutlet weak var afterLogginView: UIView!
    @IBOutlet weak var afterLogginUserName: UILabel!
    
    @IBOutlet weak var signBtnOL: UIButton!
    @IBOutlet weak var googleSigninBtnOL: UIButton!
    @IBOutlet weak var fbSigninBtnOL: UIButton!
    @IBOutlet weak var dissMissView: UIButton!
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations on signed in user here.
        self.setUIEnabled(enabled: false)
        
        guard user != nil else {
            self.setUIEnabled(enabled: true)
            return
        }
        guard let id = user.userID , let email = user.profile.email ,  let userImage = user.profile.imageURL(withDimension: 400) else {
            UserDefaults.standard.setValue(nil, forKey: "userID")
            self.setUIEnabled(enabled: true)
            return
        }
        
        print("userId :\(id)")
        print("email :\(email)")
        UIView.animate(withDuration: 5.0, delay: 0,
                       options: UIViewAnimationOptions.curveEaseOut, animations: {
                        self.afterLogginView.alpha = 1.0
            },  completion: { [weak self] finished in
                UserDefaults.standard.setValue(id, forKey: "userID")
                self?.imageURlToImage(imageURL: userImage)
                ad.reloadApp()
            })
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
    
    func setUIEnabled(enabled:Bool) {
        self.fbSigninBtnOL.isEnabled = enabled
        self.googleSigninBtnOL.isEnabled = enabled
        self.signBtnOL.isEnabled = enabled
        self.dissMissView.isEnabled = enabled
        
        if enabled {
            print("true")
            fbSigninBtnOL.alpha = 1.0
            googleSigninBtnOL.alpha = 1.0
            signBtnOL.alpha = 1.0
            dissMissView.alpha = 1.0
            
        }else {
            print("false")
            fbSigninBtnOL.alpha = 0.5
            googleSigninBtnOL.alpha = 0.5
            signBtnOL.alpha = 0.5
            dissMissView.alpha = 0.5
        }
        
    }
    
    func imageURlToImage(imageURL:URL) {
        
        
        let imageData = NSData(contentsOf: imageURL)
        
        UserDefaults.standard.setValue(imageData, forKey: "profileImage")
        
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
        
//        setUIEnabled(enabled: true)
        
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
         self.setUIEnabled(enabled: false )
        if error != nil {
            print(error)
             self.setUIEnabled(enabled: true)
            return
        }
        
        print("Successfully logged in with facebook...")
        
        showFbEmailAddress()
    }
    
    @IBAction func fbLoginBtnAct(_ sender: AnyObject) {
        
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, err ) in
            if err != nil {
                print("Custom FB Login failed",err)
                 self.setUIEnabled(enabled: true)
                return
            }
            //            print(result?.token.tokenString)
            self.setUIEnabled(enabled: false)
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
        self.setUIEnabled(enabled: false)
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id, name, email,first_name,last_name,picture"]).start { (connection, result, err) in
            
            if err != nil {
                self.setUIEnabled(enabled: true)
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
        self.setUIEnabled(enabled: false)
        GIDSignIn.sharedInstance().signIn()
        
        /*
         GIDSignIn.sharedInstance().signOut()
         */
    }
    
    
    @IBAction func dismissView(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
}

