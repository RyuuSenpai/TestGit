//
//  SignUpDatePickerExt.swift
//  HyperApp
//
//  Created by Killvak on 05/01/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation


extension SignupVC {
    
    func setTextDelegation() {
        self.firstTextOL.delegate =  RegisterTFDelegate
        self.lastNameTextOL.delegate =  RegisterTFDelegate
        self.emailText.delegate =  RegisterTFDelegate
        self.BirthDateText.delegate =  self
        self.passwordText.delegate =  RegisterTFDelegate
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignupVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    


    
}
