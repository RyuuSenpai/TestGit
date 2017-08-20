//
//  LargeHomeCategoriesCell.swift
//  HyperApp
//
//  Created by Killvak on 09/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class LargeHomeCategoriesCell: UICollectionViewCell  , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UICollectionViewDelegate{
    
    @IBOutlet weak var CategoryCollectionView: UICollectionView!
    
    @IBOutlet weak var seeMore: UIButton!
    
    var productCategories : [GetAllCategoriesModel]?
    
    var catPageNumber = 0
    var productCatData : ProductCategories?

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        CategoryCollectionView.register(subLargeHomeCategoriesCell.nib, forCellWithReuseIdentifier: subLargeHomeCategoriesCell.identifier)
        CategoryCollectionView.delegate = self
        CategoryCollectionView.dataSource = self
        
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    
    
    
    
    
    var categoriesHomePageVC : HomePageVC?
    var catIndexPath  : Int?
    
    
    
    
    
//    let imageList = [ #imageLiteral(resourceName: "Fire"),#imageLiteral(resourceName: "Air"),#imageLiteral(resourceName: "ice"),#imageLiteral(resourceName: "water")]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = productCategories?.count {
            return count 
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: subLargeHomeCategoriesCell.identifier, for: indexPath as IndexPath) as! subLargeHomeCategoriesCell
        cell.productCategory = productCategories?[indexPath.row]
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.backgroundColor = UIColor.cyan
//        if indexPath.row <= 3 {
//            cell.cell.categoryImage.image.image = imageList[indexPath.row]
        guard let data = productCategories else { return cell }
        cell.categoryImage.af_setImage(
            withURL: URL(string: data[indexPath.row].image )!,
            placeholderImage: UIImage(named: "PlaceHolder"),
            filter: nil,
            imageTransition: .crossDissolve(0.2)
        )
//        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            let x =  collectionView.frame.height * 0.8
            return CGSize(width: x, height: x ) // The size of one cell
        }else {
            let x =  collectionView.frame.height * 0.47
            return CGSize(width: x, height: x) // The size of one cell
        }
        
    }
    
    
    @IBAction func seeMore(_ sender: AnyObject) {
        
    }
    
    
    func infiniteScroll() {
        //Stop Animation
        //        mainProductsRow.setShouldShowInfiniteScrollHandler { (_) -> Bool in
        //
        //            return true
        //        }
        CategoryCollectionView.addInfiniteScroll { (collectionView) -> Void in
            self.CategoryCollectionView.performBatchUpdates({ () -> Void in
                 self.updateData()
                // update collection view
            }, completion: { (finished) -> Void in
                // finish infinite scroll animations
                self.CategoryCollectionView.finishInfiniteScroll()
            });
        }
    }
    
    
    // MARK: UICOllectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("selected Product indexPath \(indexPath)  collectionView \(collectionView)")
        guard let data = productCategories  else { return }
         let id = data[indexPath.row].id
        categoriesHomePageVC?.showSubCategory(catIndex: id, brandIndex: nil 	 )
    }
    
    
    func updateData() {
      
        catPageNumber += 1
        productCatData = ProductCategories()
  
        productCatData?.getAllCategories(pageNum: self.catPageNumber, compeleted: { (arrayofCategories) in
            
            if let cats = self.productCategories {
                let newCats = cats + arrayofCategories
                self.productCategories = newCats
            }else {
                self.productCategories = arrayofCategories
            }
            print("Done with getting Data")
            self.CategoryCollectionView.reloadData()
        })

    }
    
}
