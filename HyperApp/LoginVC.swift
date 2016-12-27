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
    
    
    @IBOutlet weak var afterLogginView: UIView!
    @IBOutlet weak var afterLogginUserName: UILabel!
    
    @IBOutlet weak var signBtnOL: UIButton!
    @IBOutlet weak var googleSigninBtnOL: UIButton!
    @IBOutlet weak var fbSigninBtnOL: UIButton!
    @IBOutlet weak var dissMissView: UIButton!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        googleProtocol()
        
        keyboardViewDIdLoad()
        
    }
    
    //MARK: - KeyBoardOutOfTheWay
    func keyboardViewDIdLoad(){
        NotificationCenter.default.addObserver(self, selector: #selector(SignupVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignupVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignupVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //@End of KeyBoard
    
    func setUIEnabled(enabled:Bool) {
        self.fbSigninBtnOL.isEnabled = enabled
        self.googleSigninBtnOL.isEnabled = enabled
        self.signBtnOL.isEnabled = enabled
        self.dissMissView.isEnabled = enabled
        
        if enabled {
            fbSigninBtnOL.alpha = 1.0
            googleSigninBtnOL.alpha = 1.0
            signBtnOL.alpha = 1.0
            dissMissView.alpha = 1.0
            
        }else {
            fbSigninBtnOL.alpha = 0.5
            googleSigninBtnOL.alpha = 0.5
            signBtnOL.alpha = 0.5
            dissMissView.alpha = 0.5
        }
        
    }
    
    @IBAction func dismissView(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: - Facebook deledate Protocoal
    
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
    
    func showFbEmailAddress(){
        self.setUIEnabled(enabled: false)
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id, name, email,first_name,last_name,picture"]).start { (connection, result, err) in
            
            if err != nil {
                self.setUIEnabled(enabled: true)
                print("failed to start graph request :  ",err)
                
            }else {
                
                let resultD = result as? NSDictionary
                if let result = resultD {
                    
                    guard let id = result["id"] as? String , let fName = result["first_name"] as? String ,let email  = result["email"] as? String  else {return }
                    print(id)
                    self.afterLogginUserName.text = fName.capitalized
                    let imageURL = URL(string: "http://graph.facebook.com/\(id)/picture?type=large")
                    let imageString : String =  "\(imageURL!)"
                    
                    self.afterLogginView.fadeIn(duration: 1.5, delay: 0, completion: { (finished: Bool) in
                        
                        ad.saveUserLogginData(email: email, photoUrl: imageString)
                        ad.reloadApp()
                    })
                }
            }
        }
    }
    
    //@End FB Delegate
    
    
    //MARK: - Google
    
    @IBAction func googleSignIn(_ sender: AnyObject) {
        self.setUIEnabled(enabled: false)
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations on signed in user here.
        self.setUIEnabled(enabled: false)
        
        guard user != nil else {
            self.setUIEnabled(enabled: true)
            return
        }
        guard let id = user.userID , let email = user.profile.email ,  let userImage = user.profile.imageURL(withDimension: 400) ,  let firstName = user.profile.givenName else {
                ad.saveUserLogginData(email: nil, photoUrl: nil)
            self.setUIEnabled(enabled: true)
            return
        }
        
        print("userId :\(id)")
        print("email :\(email)")
        let imageString : String = "\(userImage)"
        self.afterLogginUserName.text = firstName
        UIView.animate(withDuration: 2.5, delay: 0,
                       options: UIViewAnimationOptions.curveEaseOut, animations: {
                        self.afterLogginView.alpha = 1.0
            },  completion: {  finished in
                    ad.saveUserLogginData(email: email, photoUrl: imageString)
                    ad.reloadApp()
         
        })
        
        
        /*
         let idToken = user.authentication.idToken
         let fullName = user.profile.name
         let familyName = user.profile.familyName
         let userImage = user.profile.imageURL(withDimension: 400)
         print("idToken :\(idToken)")
         print("fullName :\(fullName)")
         print("familyName :\(familyName)")
         print("userImage :\(userImage)")
         */
        
    }
    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        print(" didDisconnectWith ")
    }
    
    func googleProtocol() {
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        
        if configureError != nil {
            print(configureError)
        }
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
}



