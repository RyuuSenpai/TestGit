//
//  SubCategoryVC.swift
//  HyperApp
//
//  Created by Killvak on 11/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class SubCategoryVC: UIViewController  , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerImage: UIImageView!
    
    
    var catID : Int?
//    var postRequest : PostRequests?
    override func viewDidLoad() {
        super.viewDidLoad()
        catID = 1
        collectionView.register(ProductCell.nib, forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
//        postRequest = PostRequests()
//        if let catId = self.catID {
//        postRequest?.getCatProductsDetailsData(catID: catId, completed: { (productsArray) in
//            print("that is the array ood getitems By Cat : \(productsArray)")
//            
//        })
//        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath as IndexPath) as! ProductCell

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height  :CGFloat = (self.view.frame.size.width * 0.47) * 1.5
        let width : CGFloat = self.view.frame.size.width * 0.43
        print("that is the not fixed width \(self.view.frame.size.width * 0.45)")

        return CGSize(width: width , height: height) //
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
