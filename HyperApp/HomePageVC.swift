//
//  HomePageVC.swift
//  HyperApp
//
//  Created by Killvak on 18/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController  ,  UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var sideMenuBOL: UIBarButtonItem!
    @IBOutlet weak var PromotionscrollView: UIScrollView!
    @IBOutlet weak var categoriesContainerView: UIView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    @IBOutlet weak var mainProductsRow: UICollectionView!
    @IBOutlet weak var cartBarButton: UIBarButtonItem!
    
    
    private let reuseIdentifier = "CategoriesCell"
    
    var itemsInCart : Int {
        get {
            do {
                let items = try context.fetch(CDOnCart.fetchRequest())
               return  items.count
            } catch let error as NSError {
                print("OnCart Badge error : \(error )")
            }
        return 0
        }
 
    }
    
    var productCategory : [ProductCategories]?
    let imagelist = [UIImage(named:"0"),UIImage(named:"1"),UIImage(named:"2"),UIImage(named:"3"),UIImage(named:"4"),UIImage(named:"5")]
    
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productCategory = ProductCategories.productCategories()
        PromotionImageProtocoal(scrollView : PromotionscrollView)
        
        self.cartBarButton.badgeBGColor = UIColor.red
        self.cartBarButton.badgeTextColor = UIColor.white
        self.cartBarButton.badgeValue = "\(itemsInCart)"
        self.cartBarButton.shouldAnimateBadge = true
        self.cartBarButton.shouldHideBadgeAtZero = true
        
        if  itemsInCart >= 1 {
            self.cartBarButton.tintColor = UIColor.black
        }else {
            self.cartBarButton.tintColor = UIColor.white
        }

        if self.revealViewController() != nil {
            sideMenuBOL.target = self.revealViewController()
            sideMenuBOL.action = #selector(SWRevealViewController.revealToggle(_:))
                self.revealViewController().rearViewRevealWidth = self.view.frame.width * 0.75
//                 self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        mainProductsRow.delegate = self
        mainProductsRow.dataSource = self
    }
    
    

    
    func cartNumberOfItemsBadge(){
        do {
            let items = try context.fetch(CDOnCart.fetchRequest())
            print("that is items in count \(items.count)")
           
            self.cartBarButton.badgeValue = "\(items.count)"
            
        } catch let error as NSError {
            print("OnCart Badge error : \(error )")
        }

        self.cartBarButton.shouldAnimateBadge = true
        self.cartBarButton.shouldHideBadgeAtZero = true
        if  itemsInCart >= 1 {
            self.cartBarButton.tintColor = UIColor.black
            
        }else {
            self.cartBarButton.tintColor = UIColor.white
        }
    }
    
    
    
    @IBAction func tappedPromotionImage(_ sender: AnyObject) {
        
        tappedPromotionImg(scrollView : PromotionscrollView)

    }
    
    
    @IBAction func searchGesture(_ sender: AnyObject) {
        print("Search clicked")
        guard let userID =  (UserDefaults.standard.value(forKey: "userID")) else {
            print(" USer ID = nil")
            return
        }
        print("\(userID)")
        

    }
    
    

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICOllectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if collectionView == self.categoriesCollectionView {
            return 9
        }else {
            if let count = productCategory?.count {
                            return count
            }
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            // Configure the cell  RowCell
            return cell
            
        } else  {
            let   cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "RowCell", for: indexPath) as! HomeCategoriesCell
            
            cell.categoriesHomePageVC = self
            cell.catIndexPath = indexPath.row
            cell.productCategory = productCategory?[indexPath.row]
            
            return cell
            
        }
    }
    
    
    
    
    
    
    func showProductDetailsVC(productDetails : Int , CatIndex : Int , product : productDetails?) {
        let productDetailController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC

        productDetailController.products = product
        
        navigationController?.pushViewController(productDetailController, animated: true)
    }
    // MARK: UICOllectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.categoriesCollectionView {
            
            let productDetailController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
            //            productDetailController.productNumber =  0
            //            productDetailController.categoryNumber = indexPath.row
            navigationController?.pushViewController(productDetailController, animated: true)
            
        }
        
    }
    
    // MARK: UICOllectionViewLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.categoriesCollectionView {
            
            if indexPath.row == 0 {
                return CGSize(width: 180, height: 180) // The size of one cell
            }else {
                return CGSize(width: 102, height: 102) // The size of one cell
            }
        }else {
            
            return CGSize(width: self.mainProductsRow.frame.width, height:264)
            //            return CGSize(width: self.mainProductsRow.frame.width, height: view.frame.height * 0.25)
        }
    }
    @IBAction func CartBtnA(_ sender: AnyObject) {
        
        
        
    }
    
    
    
}
