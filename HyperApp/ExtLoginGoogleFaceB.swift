//
//  ExtLogin2.swift
//  HyperApp
//
//  Created by Killvak on 06/01/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import Google
import GoogleSignIn
import FBSDKLoginKit
import CDAlertView

extension LoginVC  :  GIDSignInUIDelegate, GIDSignInDelegate  , FBSDKLoginButtonDelegate  {
    
    
    
    //MARK: - Facebook deledate Protocoal
    @IBAction func fbLoginBtnAct(_ sender: AnyObject) {
        
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, err ) in
            if err != nil {
                print("Custom FB Login failed",err)
                self.setUIEnabled(enabled: true)
                return
            }
            print("Custom FB Login result \(result)")

//            if let x  = result  {
//                print("that is  token : \(x)")
//                self.fbToken = x.token.tokenString
                self.showFbEmailAddress()

//            }else {
//                            self.setUIEnabled(enabled: false)
//            }
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
                    print("that is the result : for facebook : \(resultD)")
                    guard let id = result["id"] as? String ,let lastName = result["last_name"] as? String  , let fName = result["first_name"] as? String ,let email  = result["email"] as? String  else {return }
                    print(id)
                    self.afterLogginUserName.text = fName.capitalized
                    let imageURL = URL(string: "http://graph.facebook.com/\(id)/picture?type=large")
                    let imageString : String =  "\(imageURL!)"
                    
                        self.postClass.fbLoginPostRequest(firstName: fName, lastName: lastName, ImageUrl: imageString, email: email, birthday: nil, gender: nil, Token: /*self.fbToken ??*/ "", id: id, completion: { (status, responseId) in
                            
                            guard status , let id = responseId  else {
                                CDAlertView(title: "Couldn't Login", message: "Please try again", type: .notification).show()
                                self.setUIEnabled(enabled: true)
                                return
                            }
                            self.afterLogginView.fadeIn(duration: 1.5, delay: 0, completion: { (finished: Bool) in

                            ad.saveUserLogginData(email: email, photoUrl: imageString , uid : id)
                            ad.reloadApp()
                        })
                        
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
            ad.saveUserLogginData(email: nil, photoUrl: nil , uid : nil)
            self.setUIEnabled(enabled: true)
            return
        }
         print("userId :\(id)")
        print("email :\(email)")
        let imageString : String = "\(userImage)"
        self.afterLogginUserName.text = firstName
        
        self.postClass.googleLoginPostRequest(firstName: firstName, lastName: user.profile.familyName, ImageUrl: imageString, email: email, birthday: "", gender: "", Token: id) { (status,idCode) in
            guard status else {
                CDAlertView(title: "Couldn't Login", message: "Please try again", type: .notification).show()
   self.setUIEnabled(enabled: true)
                return
            }
            DispatchQueue.main.async {
                
                UIView.animate(withDuration: 2.5, delay: 0,
                               options: UIViewAnimationOptions.curveEaseOut, animations: {
                                self.afterLogginView.alpha = 1.0
                },  completion: {  finished in
                    ad.saveUserLogginData(email: email, photoUrl: imageString , uid : idCode)
                    ad.reloadApp()
                    
                })
                
            }
        }
      
        
        
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
