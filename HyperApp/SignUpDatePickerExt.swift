//
//  SignUpDatePickerExt.swift
//  HyperApp
//
//  Created by Killvak on 05/01/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation


extension SignupVC {
    
    
    
  func addToolBarToPicker()  {
    let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(SignupVC.closekeyboard))
    BirthDateText.inputAccessoryView = toolBar
    
    
    }
    
    
    func datePickerChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.dateToSend = sender.date
        BirthDateText.text = formatter.string(from: sender.date)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == BirthDateText {
       datePickerFunc(textField: BirthDateText)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == BirthDateText , (textField.text?.characters.count)! <= 1{
            let date = Calendar.current.date(byAdding: .year, value: -16, to: Date())
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            BirthDateText.text = formatter.string(from: date!)
            self.dateToSend =  date
        }
    }
    
    func datePickerFunc(textField:UITextField) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -16, to: Date())
        textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        BirthDateText.resignFirstResponder()
//        return true
//    }
    
    // MARK: Helper Methods
    func closekeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
    
    
    
    
}
