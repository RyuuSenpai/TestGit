//
//  ProductDetailsVC.swift
//  HyperApp
//
//  Created by Killvak on 24/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController    /* , UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout*/ {
    @IBOutlet weak var floatRatingView: FloatRatingView!
    @IBOutlet weak var productImagescrollView: UIScrollView!

    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    
    @IBOutlet weak var RelatedItemsCollectionView: UICollectionView!
//    @IBOutlet weak var categoryID: UILabel!
//    @IBOutlet weak var productID: UILabel!
    @IBOutlet weak var numperOfReviews: UIButton!
    @IBOutlet weak var favItemBOL: UIButton!
    @IBOutlet weak var addTOCarBOL: UIButton!

    @IBOutlet weak var productTitle: UILabel?
    
    @IBOutlet weak var priceOL: UILabel!

    @IBOutlet weak var preDicountPrice: UILabel!

    var CurrentRating : String?
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
    
    var products : productDetails?
    
    func updateUI() {
        
        if let title = products?.name {
            productTitle!.text = title
        }
        if let price = products?.price{
            priceOL.text = "\(price) L.E"
        }
        if let prePrice = products?.preDiscountPrice {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(prePrice) L.E")
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: NSMakeRange(0, attributeString.length))
            preDicountPrice.attributedText = attributeString
        }

    }

        let imagelist = [UIImage(named:"0"),UIImage(named:"1"),UIImage(named:"2"),UIImage(named:"3"),UIImage(named:"4"),UIImage(named:"5")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PromotionImageProtocoal(scrollView: productImagescrollView)
        RatingProtocoal()
        exCollectionVDelegateProtocoal()
        exCollectionVDataSourceProtocoal()
        updateUI()
        print("\(categoryNumber)")
        print("\(productNumber)")
//        if let productid  = productNumber {
//            productID.text = " product ID : \(productid)"
//        }
//        if let catID = categoryNumber {
//            categoryID.text = " category ID : \(catID)"
//        }
    }


    @IBAction func tappedProductImage(_ sender: AnyObject) {
        tappedPromotionImg(scrollView : productImagescrollView)

    }


    @IBAction func descriptionTapGesture(_ sender: AnyObject) {
        print("Open description Page")
    }
    @IBAction func numberOfreviewBA(_ sender: AnyObject) {
        print("that is the current rating : \(self.CurrentRating)")
    }
    @IBAction func specificationTapGesture(_ sender: AnyObject) {
        print("That is Specifications TapGesture ")
    }
    
    @IBAction func SeeAllBA(_ sender: UIButton) {
        print("See All Button Tapped ")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addTOCarBA(_ sender: AnyObject) {
        print("add to Cart ")
    }
    @IBAction func favItemBA(_ sender: AnyObject) {
        print("add to fav list  ")
    }
    @IBAction func buyNowBA(_ sender: AnyObject) {
        print("Buy buyNow ")
    }
    
    @IBAction func peopleAlsoViewdSeeAllBA(_ sender: AnyObject) {
       print("Related Item See All")
    }
    
    

}
