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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.reviewsCollectionView {

        print("That is the index of the Review Cell : \(indexPath.row)")
            
            let reviewVC = storyboard?.instantiateViewController(withIdentifier: "SeeReviews") as! SeeReviews
            reviewVC.indexIs = indexPath.row
            navigationController?.pushViewController(reviewVC, animated: true )
        } else {
            print("That is the index of the Related item Cell : \(indexPath.row)")

        }
    }
}
