//
//  ProductCollectionVDelegate.swift
//  HyperApp
//
//  Created by Killvak on 26/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import UIKit

extension ProductDetailsVC : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func exCollectionVDelegateProtocoal() {
        
        self.reviewsCollectionView.delegate = self
        self.RelatedItemsCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.reviewsCollectionView {
            return CGSize(width: collectionView.frame.width * 0.90 , height: 158) // The size of one cell
            
        }else {
            return CGSize(width: 150, height: 234)
            
        }
        
    }
}

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
            return cell
        }
    }
}
