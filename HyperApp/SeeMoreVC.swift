//
//  SeeMoreVC.swift
//  HyperApp
//
//  Created by Killvak on 16/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AlamofireImage

class SeeMoreVC: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var catID : Int?
    var productCatSelected : ProductCategories?
    
    var postRequest : PostRequests?

    var productsArray : [ProductDetails]?
    let onCartFuncsClass = OnCartFunctionality()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.squareLoading.start(0.0)
        collectionView.register(ProductCell.nib, forCellWithReuseIdentifier: ProductCell.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
         postRequest = PostRequests()

        print("that is the cat id : \(catID)")
        postRequest?.getCatProductsDetailsData(catID: productCatSelected?.catDetails?.id, completed: { [unowned self ](productsArray) in
            print("that is the array ood getitems By Cat : \(productsArray)")
            self.productsArray = productsArray
            self.view.squareLoading.stop(0.0)
            
            self.getImageProductDetails()
self.collectionView.reloadData()
        })
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = productsArray?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath as IndexPath) as! ProductCell
        if let products = productsArray {
            let x = products[indexPath.row]
            cell.productDetails = x
            if x.image_pr != nil {
                 cell.productImage.image = x.image_pr
             }else {
            cell.productImage.image = UIImage(named: "PlaceHolder")
            }
//            cell.cartBtnOL.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControlEvents#>)
        }
        return cell
        
    }
    
    
    func getImageProductDetails() {
        for pd in self.productsArray! {
            guard let imgStrUrl = pd.image_url else {return }
            Alamofire.request(imgStrUrl).responseImage { response in
                debugPrint(response)
                
//                print(response.request)
//                print(response.response)
                debugPrint(response.result)
                
                if let image = response.result.value {
                    print("image downloaded: \(image)")
                    pd.image_pr = image
                    self.collectionView.reloadData()
                }
            }
        }
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
