//
//  WriteReviewVC.swift
//  HyperApp
//
//  Created by Killvak on 11/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class WriteReviewVC: UIViewController {

    @IBOutlet weak var floatRatingView: FloatRatingView!

    override func viewDidLoad() {
        super.viewDidLoad()

        RatingProtocoal()
    }
    /*
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
    */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
