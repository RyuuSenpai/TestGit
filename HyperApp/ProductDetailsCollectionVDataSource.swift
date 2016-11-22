//
//  ProductDetailsCollectionVDataSource.swift
//  HyperApp
//
//  Created by Killvak on 26/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import UIKit




extension ProductDetailsVC : UICollectionViewDataSource {
    
    func exCollectionVDataSourceProtocoal() {
        
        self.reviewsCollectionView.dataSource = self
        self.RelatedItemsCollectionView.dataSource = self
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.reviewsCollectionView {
            return 5
        }else {
            return 11
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //RelatedItemsCell
        
        if collectionView == self.reviewsCollectionView {
            let cell : ProductReviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ProductReviewCell
            return cell
        }else {
            let cell : RelatedItemsProductDetailsVCCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RelatedItemsCell", for: indexPath) as! RelatedItemsProductDetailsVCCell
            
            cell.favButton.tag = indexPath.row
            cell.favButton.addTarget(self, action:#selector(ProductDetailsVC.favButtonA(_:)), for: .touchUpInside)
            cell.addToCartBtn.tag = indexPath.row
            cell.addToCartBtn.addTarget(self, action: #selector(ProductDetailsVC.cartButtonA(_:)), for: .touchUpInside)
            cell.shareBtn.tag = indexPath.row
            cell.shareBtn.addTarget(self, action: #selector(ProductDetailsVC.shareButtonA(_:)), for: .touchUpInside)
            
            return cell
        }
    }
    
 
    func favButtonA(_ sender: UIButton) {
        
        print("that is the button index : \(sender.tag)")
        
        selectedButton(sender: sender, selectedBtn: "heart_icon_selected", disSelectImage: "Heart_icon")
    }
    
    func cartButtonA(_ sender: UIButton) {
        
        print("that is the button index : \(sender.tag)")
        
        selectedButton(sender: sender, selectedBtn: "carticon", disSelectImage: "cart")
        
    }
    
    func shareButtonA(_ sender: UIButton) {
        
        print("that is the button index : \(sender.tag)")
        selectedButton(sender: sender, selectedBtn: "favoriteditemenabled", disSelectImage: "favoriteditem")
    }
    
//    func selectedButton( sender : UIButton , selectedBtn : String , disSelectImage : String) {
//        sender.isSelected = !sender.isSelected
//        if(sender.isSelected == true)
//        {
//            sender.setImage(UIImage(named:selectedBtn), for: UIControlState.normal)
//        }
//        else
//        {
//            sender.setImage(UIImage(named:disSelectImage), for: UIControlState.normal)
//        }
//    }
    
    
}
