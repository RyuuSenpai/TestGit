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
    @IBOutlet weak var cartBarButton: UIBarButtonItem!

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
    @IBAction func addTOCarBA(_ sender: UIButton) {
        print("add to Cart ")
        selectedButton(sender: sender, selectedBtn: "carticon", disSelectImage: "cart")
        
        
    }
    @IBAction func favItemBA(_ sender: UIButton) {
        print("add to fav list  ")
        selectedButton(sender: sender, selectedBtn: "hearticon", disSelectImage: "heart")
        
        
    }
    @IBAction func buyNowBA(_ sender: UIButton) {
        print("Buy buyNow ")
        
        if ad.isUserLoggedIn() {

            let data = products
            
            saveCartItemsInCoreData(data: data)
            
            
            
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
    
    
    func saveCartItemsInCoreData(data:productDetails?) {
        let fetchRequest : NSFetchRequest<CDOnCart> = CDOnCart.fetchRequest()
        let  predicate = NSPredicate(format: "name == %@", (data?.name)!)
        fetchRequest.predicate = predicate
        do {
            
            
            let fetcjResult = try context.fetch(fetchRequest)
            if fetcjResult.count > 0 {
                print("Already Fav")
            }else {
                
                let CartItem = CDOnCart(context: context)
                context.mergePolicy = CartItem
                CartItem.name  = data?.name
                CartItem.quantity = 1
                CartItem.price = data?.price as! Double
                ad.saveContext()
                print("saved data")
            }
        } catch let error as NSError {
            print("That is the error in FavListCoreData : \(error.localizedDescription)")
        }
        

    }
    
    
    
    func selectedButton( sender : UIButton , selectedBtn : String , disSelectImage : String) {
        sender.isSelected = !sender.isSelected
        let shareImage = "favoriteditemenabled"
        let data = products
        
        if(sender.isSelected == true)
        {
            sender.setImage(UIImage(named:selectedBtn), for: UIControlState.normal)
            if selectedBtn == "carticon" {
                
             saveCartItemsInCoreData(data: data)
                
            }else if selectedBtn ==  shareImage {
                
                
            }else {
                
                let fetchRequest : NSFetchRequest<CDFavList> = CDFavList.fetchRequest()
                print("that is hte shit id : \((data?.id)!)"   )
                let  predicate = NSPredicate(format: "name == %@", (data?.name)!)
                fetchRequest.predicate = predicate
                do {
                    
                    
                    let fetcjResult = try context.fetch(fetchRequest)
                    if fetcjResult.count > 0 {
                        print("Already Fav")
                    }else {
                        
                        let favItem = CDFavList(context: context)
                        context.mergePolicy = favItem
                        favItem.name  = data?.name
                        ad.saveContext()
                        print("saved data")
                    }
                } catch let error as NSError {
                    print("That is the error in FavListCoreData : \(error.localizedDescription)")
                }
            }
        }
        else
        {
            sender.setImage(UIImage(named:disSelectImage), for: UIControlState.normal)
            
            if selectedBtn == "carticon" {
                
                let fetchRequest : NSFetchRequest<CDOnCart> = CDOnCart.fetchRequest()
                let  predicate = NSPredicate(format: "name == %@", (data?.name)!)
                fetchRequest.predicate = predicate
                do {
                    
                    
                    let fetcjResult = try context.fetch(fetchRequest)
                    if fetcjResult.count > 0 {
                        print("Already Fav")
                        print("will delete : \((data?.name)!)")
                        context.delete(fetcjResult[0])
                        ad.saveContext()
                    }
                }catch {
                    print("Fetching failed")
                }
                
            }else  if selectedBtn == shareImage {
                
            } else {
                
                let fetchRequest : NSFetchRequest<CDFavList> = CDFavList.fetchRequest()
                let  predicate = NSPredicate(format: "name == %@", (data?.name)!)
                fetchRequest.predicate = predicate
                do {
                    
                    
                    let fetcjResult = try context.fetch(fetchRequest)
                    if fetcjResult.count > 0 {
                        print("Already Fav")
                        print("will delete : \((data?.name)!)")
                        context.delete(fetcjResult[0])
                        ad.saveContext()
                    }
                }catch {
                    print("Fetching failed")
                }
                
            }
        }
    }
    
    
    
}
