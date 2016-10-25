//
//  ProductDetailsVC.swift
//  HyperApp
//
//  Created by Killvak on 24/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {

    @IBOutlet weak var categoryID: UILabel!
    @IBOutlet weak var productID: UILabel!

    
    var categoryNumber : Int? /*{
        didSet {
            if let catID = categoryNumber {
                categoryID.text = "That is the category ID :\(catID)"
            }
        }
    }*/
    var productNumber : Int?/* {
        didSet {
            if let productid  = productNumber {
                productID.text = "That is the category ID :\(productid)"
            }
        }
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("\(categoryNumber)")
        print("\(productNumber)")
        if let productid  = productNumber {
            productID.text = " product ID : \(productid)"
        }
        if let catID = categoryNumber {
            categoryID.text = " category ID : \(catID)"
        }
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
