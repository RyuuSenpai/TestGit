//
//  ProductDetailsVC.swift
//  HyperApp
//
//  Created by Killvak on 24/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit
import CoreData
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
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productTitle: UILabel?
    @IBOutlet weak var priceOL: UILabel!
    @IBOutlet weak var preDicountPrice: UILabel!
    
    var  toCartVC : UIBarButtonItem!
    
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
    var product_id : Int?
    var products : ProductDetails?
    var imagelist = [#imageLiteral(resourceName: "PlaceHolder"),#imageLiteral(resourceName: "PlaceHolder"),#imageLiteral(resourceName: "PlaceHolder"),#imageLiteral(resourceName: "PlaceHolder"),#imageLiteral(resourceName: "PlaceHolder")]
    
    var getDataClass : ProductCategories!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toCartVC = UIBarButtonItem(image: UIImage(named: "GoToCartIcon"), style: .plain, target: self, action : #selector(self.pushToOnCart(_:)))
        self.navigationItem.rightBarButtonItem  = toCartVC
        //GonMade
        updateUI()
        RatingProtocoal()
        exCollectionVDelegateProtocoal()
        exCollectionVDataSourceProtocoal()
        print("\(categoryNumber)")
        print("\(productNumber)")
        favAndCartIconState()
        
        //        if let productid  = productNumber {
        //            productID.text = " product ID : \(productid)"
        //        }
        //        if let catID = categoryNumber {
        //            categoryID.text = " category ID : \(catID)"
        //        }
        
        recivedNotification()
    }
    
    
    func updateUI() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.toCartVC.isEnabled = false
        
        self.view.squareLoading.start(0.0)
        
        getDataClass = ProductCategories()
        getDataClass.getproductDetailsData(itemID: product_id) { (data) in
            if data != nil {
                self.products = data
            }
            if let title = self.products?.name {
                self.productTitle!.text = title
            }
            if let price = self.products?.price{
                self.priceOL.text = "\(price) L.E"
            }
            if let prePrice = self.products?.preDiscountPrice {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(prePrice) L.E")
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1.5, range: NSMakeRange(0, attributeString.length))
                self.preDicountPrice.attributedText = attributeString
            }
            if let descrip = self.products?.prDescription {
                self.descriptionLabel.text = descrip
            }
            if let img = self.products?.image_pr {
                self.imagelist = [img]
            }
            if self.products?.on_sale == nil {
                self.preDicountPrice.isHidden = true
            }
            self.drawViewSetUps()
            self.view.squareLoading.stop(0.0)
            self.toCartVC.isEnabled = true
            self.navigationItem.setHidesBackButton(false, animated: true)
        }
    }
    
    func drawViewSetUps() {
        PromotionImageProtocoal(scrollView: productImagescrollView)
    }
    
    
    
    func favAndCartIconState() {
        let favFuncsClass = FavItemsFunctionality()
        let onCartFuncsClass = OnCartFunctionality()
        if favFuncsClass.saveFavData(data: products, state: nil){
            favItemBOL.setBackgroundImage(UIImage(named:"heart_icon_selected"), for: UIControlState.normal)
            favItemBOL.isSelected = true
        }else {
            favItemBOL.setBackgroundImage(UIImage(named:"Heart_icon"), for: UIControlState.normal)
            favItemBOL.isSelected = false
            
        }
        if onCartFuncsClass.saveCartData(data: onCartFuncsClass.transferDataToCartObj(data: products), state: nil){
            addTOCarBOL.setBackgroundImage(UIImage(named:"carticon"), for: UIControlState.normal)
            addTOCarBOL.isSelected = true
        }else {
            addTOCarBOL.setBackgroundImage(UIImage(named:"cart"), for: UIControlState.normal)
            addTOCarBOL.isSelected = false
        }
    }
    
    func recivedNotification() {
        NotificationCenter.default.addObserver(forName: REFRESH_PRODUCT_DETAILS_ICONS, object: nil, queue: nil) { notification  in
            //            let largerCell = HomeCategoriesCell()
            //            largerCell.reloadData()
            self.favAndCartIconState()
            print("recivedNotification : \(notification)")
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.revealViewController().panGestureRecognizer().isEnabled = false
        self.view.squareLoading.backgroundColor = UIColor.white
        self.view.squareLoading.color = UIColor.red
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        sendNotification()
        
    }
    func sendNotification() {
        
        NotificationCenter.default.post(name: REFRESH_HOMEPAGE_CELLS, object: nil)
        
    }
    
    func pushToOnCart(_ sender : UIButton) {
        print("cart")
        let onCartVC = self.storyboard?.instantiateViewController(withIdentifier: "OnCartVC") as! OnCartVC
        onCartVC.isNotSubView = false
        navigationController?.pushViewController(onCartVC, animated: true )
    }
    
    @IBAction func tappedProductImage(_ sender: AnyObject) {
        tappedPromotionImg(scrollView : productImagescrollView)
        
    }
    
    @IBAction func writereviewTapGesture(_ sender: AnyObject) {
        
        if ad.isUserLoggedIn() {
            
            let writereviewVC = WriteReviewsVC(nibName: "WriteReviewsVC", bundle: nil)
            self.navigationController?.pushViewController(writereviewVC, animated: true)
            //            let onCartVC = self.storyboard?.instantiateViewController(withIdentifier: "OnCartVC") as! OnCartVC
            //            onCartVC.isNotSubView = false
            //            navigationController?.pushViewController(onCartVC, animated: true)
        }else {
            performSegue(withIdentifier: "login", sender: self )
        }
        
        
    }
    
    @IBAction func descriptionTapGesture(_ sender: AnyObject) {
        print("Open description Page")
        
        //DescriptionVC
        let descriptionVC = DescriptionVC(nibName: "DescriptionVC", bundle: nil)
        descriptionVC.product = products
        self.navigationController?.pushViewController(descriptionVC, animated: true)
        
    }
    
    @IBAction func numberOfreviewBA(_ sender: AnyObject) {
        print("that is the current rating : \(self.CurrentRating)")
    }
    
    @IBAction func specificationTapGesture(_ sender: AnyObject) {
        print("That is Specifications TapGesture ")
        let specificationsVC = SpecificationsVC(nibName: "SpecificationsVC", bundle: nil)
        self.navigationController?.pushViewController(specificationsVC, animated: true)
        
    }
    
    @IBAction func SeeAllBA(_ sender: UIButton) {
        let reviewVC = storyboard?.instantiateViewController(withIdentifier: "SeeReviews") as! SeeReviews
        reviewVC.indexIs = sender.tag
        navigationController?.pushViewController(reviewVC, animated: true )
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func addTOCarBA(_ sender: UIButton) {
        print("add to Cart ")
        let onCartFuncs = OnCartFunctionality()
        onCartFuncs.cartBtnAct(sender: sender, data: products,buyNow:false)
        
        
    }
    @IBAction func favItemBA(_ sender: UIButton) {
        print("add to fav list  ")
        
        let favFuncs = FavItemsFunctionality()
        favFuncs.FavBtnAct(sender: sender, data: products)
        
    }
    
    
    @IBAction func buyNowBA(_ sender: UIButton) {
        print("Buy buyNow ")
        
        if ad.isUserLoggedIn() {
            
            
            let onCartFuncs = OnCartFunctionality()
            onCartFuncs.cartBtnAct(sender: sender, data: products,buyNow:true)
            
            let onCartVC = self.storyboard?.instantiateViewController(withIdentifier: "OnCartVC") as! OnCartVC
            onCartVC.isNotSubView = false
            navigationController?.pushViewController(onCartVC, animated: true)
        }else {
            performSegue(withIdentifier: "login", sender: self )
        }
        
        
        
        
    }
    
    @IBAction func peopleAlsoViewdSeeAllBA(_ sender: AnyObject) {
        print("Related Item See All")
    }
    
    
    
    
    
    
    
    
    
}
