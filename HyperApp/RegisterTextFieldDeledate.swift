//
//  RegisterTextFieldDeledate.swift
//  HyperApp
//
//  Created by Killvak on 12/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import UIKit

class RegisterTextFieldDeledate : NSObject , UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag ==  2 {
        let max = 11
        if let newText = textField.text  {
            var newText : NSString = newText as NSString
            
            newText = newText.replacingCharacters(in: range, with: string ) as NSString
            
            return newText.length <= max
        }}
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */

}
