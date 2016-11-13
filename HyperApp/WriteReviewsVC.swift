//
//  WriteReviewVC.swift
//  HyperApp
//
//  Created by Killvak on 11/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class WriteReviewsVC: UIViewController , UITextViewDelegate , UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var floatRatingView: FloatRatingView!

    @IBOutlet weak var reviewTitle: UITextField!
    
    @IBOutlet weak var whatGoodText: UITextField!
    var activeField: UITextField?
    
    @IBOutlet weak var whatNotGood: UITextField!
    
    @IBOutlet weak var longReview: UITextView!
    
    var keyBoardheightSize : CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        RatingProtocoal()
        reviewTitle.delegate = self
        whatGoodText.delegate = self
        whatNotGood.delegate = self
        longReview.delegate = self
        

      
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WriteReviewsVC.dismissKeyboard))
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
                keyBoardheightSize = keyboardSize.height
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
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        NotificationCenter.default.addObserver(self, selector: #selector(WriteReviewsVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(WriteReviewsVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        print("4")
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        NotificationCenter.default.removeObserver(self,name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += keyBoardheightSize
        }
        print("5")

    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("3")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        print("1")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        print("2")
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
    
    
    
    // MARK: - Navigation
    
    //    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        // Get the new view controller using segue.destinationViewController.
    //        // Pass the selected object to the new view controller.
    //    }
    
    
}
