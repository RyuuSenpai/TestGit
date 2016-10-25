//
//  PromotionVC.swift
//  HyperApp
//
//  Created by Killvak on 24/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class PromotionVC: UIViewController {

    @IBOutlet weak var promotionImage: UIImageView!
    
    var promotionImageFlag : UIImage? 
 
        
    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = promotionImageFlag {
            promotionImage.image = image
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView(_ sender: AnyObject) {
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
