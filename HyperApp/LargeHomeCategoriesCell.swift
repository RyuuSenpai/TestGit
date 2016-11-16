//
//  LargeHomeCategoriesCell.swift
//  HyperApp
//
//  Created by Killvak on 09/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class LargeHomeCategoriesCell: UICollectionViewCell  , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UICollectionViewDelegate{
    
    @IBOutlet weak var CategoryCollectionView: UICollectionView!

    
    var productCategories : [ProductCategories]?

    
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

    
    
    
    
    // MARK: UICOllectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("selected Product indexPath \(indexPath)  collectionView \(collectionView)")
        
        categoriesHomePageVC?.showSubCategory(productDetails: indexPath.row, CatIndex: catIndexPath!)
    }
    
    
    //Test
    
    
}
