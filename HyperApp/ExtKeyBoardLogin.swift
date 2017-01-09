//
//  ExtLogin.swift
//  HyperApp
//
//  Created by Killvak on 06/01/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation

extension LoginVC {
    
    
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
}
