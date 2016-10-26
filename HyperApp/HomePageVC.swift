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
    
    
    private let reuseIdentifier = "CategoriesCell"
    
    
    
    let imagelist = [UIImage(named:"0"),UIImage(named:"1"),UIImage(named:"2"),UIImage(named:"3"),UIImage(named:"4"),UIImage(named:"5")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PromotionImageProtocoal(scrollView : PromotionscrollView)
        
        if self.revealViewController() != nil {
            sideMenuBOL.target = self.revealViewController()
            sideMenuBOL.action = #selector(SWRevealViewController.revealToggle(_:))
            //     self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        mainProductsRow.delegate = self
        mainProductsRow.dataSource = self
    }
    

    
    @IBAction func tappedPromotionImage(_ sender: AnyObject) {
        
tappedPromotionImg(scrollView : PromotionscrollView)
    }
    
    
    @IBAction func searchGesture(_ sender: AnyObject) {
        print("Search clicked")
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
            return 5
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
            return cell
            
        }
    }
    func showProductDetailsVC(productDetails : Int , CatIndex : Int) {
        let productDetailController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
        productDetailController.productNumber = productDetails
        productDetailController.categoryNumber = CatIndex
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
    
}
