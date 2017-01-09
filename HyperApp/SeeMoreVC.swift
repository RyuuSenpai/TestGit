//
//  SeeMoreVC.swift
//  HyperApp
//
//  Created by Killvak on 16/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit
import Foundation
class SeeMoreVC: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var productCatSelected : ProductCategories?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ProductCell.nib, forCellWithReuseIdentifier: ProductCell.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = productCatSelected?.products?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath as IndexPath) as! ProductCell
        let product = productCatSelected?.products?[indexPath.row]
        cell.productDetails = product
        return cell
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
