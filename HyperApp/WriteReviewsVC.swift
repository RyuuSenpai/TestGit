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
    var postReviewClass = PostReviewRequest()
    var ratingValue : Float = 2.5
    var productId : Int?
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
    
    


    
    
    @IBAction func submitReview(_ sender: UIButton) {
        if isTextValid() == "Posted",let id = self.productId {
        postReviewClass.getReviewRequesData(userID: 1 , itemID: id, rate: self.ratingValue, reviewString: self.reviewTitle.text!, completed: { (ProductDetails) in
            
            print("Done with Posting the data")
        })
        }else {
            
        }
    }
    
    
    func isTextValid() -> String{
        
        guard  let whatGoodT = self.whatNotGood.text  , whatGoodT.characters.count > 1 else {
            return "What's good about Product Text is Empty" }
        guard  let whatNotGoodT = self.whatNotGood.text  , whatNotGoodT.characters.count > 1 else {
            return "What's not good about Product Text is Empty" }
        guard  let reviewT = self.reviewTitle.text  , reviewT.characters.count > 1 else {
            return "Review Text is Empty" }
       return "Posted"
    }
    
    
    
    
    
    
    
    

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
