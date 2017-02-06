//
//  SignupVC.swift
//  HyperApp
//
//  Created by Killvak on 10/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class SignupVC: UIViewController , UITextFieldDelegate{
    
    
    @IBOutlet weak var firstTextOL: UITextField!
    @IBOutlet weak var lastNameTextOL: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var BirthDateText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var maleOrFemale: UISwitchCustom!
    @IBOutlet weak var maleBtnOL: UIButton!
    @IBOutlet weak var femaleBtnOL: UIButton!
    @IBOutlet weak var signupBtnOL: UIButton!
    @IBOutlet weak var afterLogginView: UIView!
    @IBOutlet weak var userNameLbl: UILabel!

    
    var dateToSend : Date?
    
    let RegisterTFDelegate = RegisterTextFieldDeledate()
    let signUpPostRClass = SignUpPostReq()
    var genderType = "m"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.femaleBtnOL.alpha = 0.5

        self.setTextDelegation()
        // Do any additional setup after loading the view.
        //Pick Date
        self.addToolBarToPicker()
        
        NotificationCenter.default.addObserver(self, selector: #selector(SignupVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignupVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
       
    
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self,name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self,name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @IBAction func setGender(_ sender: Any) {
        
        if maleOrFemale.isOn {
            self.maleBtnOL.alpha = 1.0
            self.femaleBtnOL.alpha = 0.5
            genderType = "m"
        }else {
            self.maleBtnOL.alpha = 0.5
            self.femaleBtnOL.alpha = 1.0
            genderType = "f"
        }
    }
    
    
    
    
    
    @IBAction func isMaleBtnAct(_ sender: UIButton) {

        self.maleBtnOL.alpha = 1.0
        self.femaleBtnOL.alpha = 0.5

        self.maleOrFemale.isOn = true
    }
    
    @IBAction func isFmaleBtnAct(_ sender: UIButton) {

        self.maleBtnOL.alpha = 0.5
        self.femaleBtnOL.alpha = 1.0
        self.maleOrFemale.isOn = false
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
    @IBAction func signupBtnAct(_ sender: UIButton) {
        
        EZLoadingActivity.show("Loading...", disableUI: true)
        guard  let result = isTextValid() , result == "Posted" else {
hidActivityMonitor()
            shotAlert(AlertSMS: isTextValid()!)
            return
            }
               signUpPostRClass.postSignupData(firstName: self.firstTextOL.text!, lastName: lastNameTextOL.text!, password: passwordText.text!, email: emailText.text!, birthDay: "\(dateToSend!)" , gender: genderType) { (response) in
                guard let r = response else { self.hidActivityMonitor() ; print("error in Signup Response") ; return }
                switch r {
                case "-1" :
                    self.hidActivityMonitor()
                    self.shotAlert(AlertSMS: "unknown Error" )
                    print("unknown Error")
                case "-2" :
                    self.hidActivityMonitor()
                    self.shotAlert(AlertSMS: "email already Exist")
                    print("email already Exist")
                default :
                    EZLoadingActivity.hide(true, animated: true)

                    print("that is the respnse : ",r)
                    self.afterLogginView.isHidden = false
                    self.userNameLbl.text = self.firstTextOL.text! + " " + self.lastNameTextOL.text!
                    self.afterLogginView.fadeIn(duration: 1.5, delay: 0, completion: { (finished: Bool) in
                        
                        ad.saveUserLogginData(email: self.emailText.text , photoUrl: nil , uid : r)
                        ad.reloadApp()
                    })
            
                }
        }
    }
    
    
    func hidActivityMonitor() {
        EZLoadingActivity.hide()

    }
    
    
    func isTextValid() -> String?{
        
        guard  let fname = self.firstTextOL.text  , fname.characters.count > 1 else {
            return "first Text is Empty" }
        guard  let lastName = self.lastNameTextOL.text  , lastName.characters.count > 1 else {
            return "last Name Text is Empty" }
        guard  let pass = self.passwordText.text  , pass.characters.count > 1 else {
            return "password Text is Empty" }
        guard  let email = self.emailText.text  , email.characters.count > 1 else {
            return "Email Text is Empty" }
        guard  let bDate = self.BirthDateText.text  , bDate.characters.count > 1 else {
            return "BirthDate Text is Empty" }
        return "Posted"
    }
    
    
   
    func shotAlert(AlertSMS : String) {

        SweetAlert().showAlert("Error!!", subTitle: AlertSMS  , style: AlertStyle.warning)
        
    }
    
    
 
}
