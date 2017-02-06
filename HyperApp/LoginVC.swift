//
//  ViewController.swift
//  HyperApp
//
//  Created by Killvak on 09/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit


class LoginVC: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var afterLogginView: UIView!
    @IBOutlet weak var afterLogginUserName: UILabel!
    
    @IBOutlet weak var emailTextOL: UITextField!
    @IBOutlet weak var passwordTextOL: UITextField!
    @IBOutlet weak var signBtnOL: UIButton!
    @IBOutlet weak var googleSigninBtnOL: UIButton!
    @IBOutlet weak var fbSigninBtnOL: UIButton!
    @IBOutlet weak var dissMissView: UIButton!
    
    
    let postClass = LoginPostRequests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        googleProtocol()
        keyboardViewDIdLoad()
        emailTextOL.delegate = self
        passwordTextOL.delegate =  self
    }
    
   
    
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
    
    
   
    @IBAction func signInLocalServes(_ sender: UIButton) {
        
        guard  let result = isTextValid() , result == "Posted" else {
            print(isTextValid())
            return
        }
        
    
    
        postClass.postLogInRequest(email: emailTextOL.text!, password: passwordTextOL.text!) { (response) in
            
            guard let r = response else { print("error in Signin Response") ; return }
            switch r {
            case "-1" :

                print("Wrong Password")
            case "-2" :

                print("No Matching Email")
            default :
                print("that is the respnse : ",r)

                self.afterLogginView.fadeIn(duration: 1.5, delay: 0, completion: { (finished: Bool) in
                    
                    ad.saveUserLogginData(email: self.emailTextOL.text, photoUrl: nil , uid : r)
                    ad.reloadApp()
                })
                
            }
        }
    }
    
    func isTextValid() -> String?{
        
        guard  let email = self.emailTextOL.text  , email.characters.count > 1 else {
            return "emailText Text is Empty" }
        guard  let passWord = self.passwordTextOL.text  , passWord.characters.count > 1 else {
            return "passWord Text is Empty" }
        return "Posted"
    }
    
   }



