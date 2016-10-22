//
//  SignupVC.swift
//  HyperApp
//
//  Created by Killvak on 10/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class SignupVC: UIViewController , UITextFieldDelegate{

    
    @IBOutlet weak var fullNameText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var mobileNumberText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    let RegisterTFDelegate = RegisterTextFieldDeledate()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fullNameText.delegate =  RegisterTFDelegate
        self.emailText.delegate =  RegisterTFDelegate
        self.mobileNumberText.delegate =  RegisterTFDelegate
        self.passwordText.delegate =  RegisterTFDelegate

        // Do any additional setup after loading the view.

        NotificationCenter.default.addObserver(self, selector: #selector(SignupVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignupVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignupVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dismissViewButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
