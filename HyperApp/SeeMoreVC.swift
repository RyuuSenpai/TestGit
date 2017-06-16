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
    var productsSearchArray : [Search_Data]?

     let onCartFuncsClass = OnCartFunctionality()
    let favFuncsClass = FavItemsFunctionality()

    var isSeemore = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.squareLoading.start(0.0)
        collectionView.register(ProductCell.nib, forCellWithReuseIdentifier: ProductCell.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        if let _ = productsArray {
         postRequest = PostRequests()

        print("that is the cat id : \(catID)")
        postRequest?.getCatProductsDetailsData(catID: productCatSelected?.catDetails?.id, completed: { [unowned self ](productsArray) in
            print("that is the array ood getitems By Cat : \(productsArray)")
            self.productsArray = productsArray
            self.view.squareLoading.stop(0.0)
            
            self.getImageProductDetails()
self.collectionView.reloadData()
        })
        }else {
            self.view.squareLoading.stop(0.0)
        }
        
        
        
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let _ = productsArray {
        if let count = productsArray?.count {
            return count
        }
         }else if let _ = productsSearchArray {
            if let count = productsSearchArray?.count {
                return count
            }
         }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath as IndexPath) as! ProductCell
//        cell.downRightBtnOL.setImage(#imageLiteral(resourceName: "Heart_icon"), for: .normal)
        if let products = productsArray {
            let x = products[indexPath.row]
            cell.productDetails = x
            if x.image_pr != nil {
                 cell.productImage.image = x.image_pr
             }else {
            cell.productImage.image = UIImage(named: "PlaceHolder")
            }
//            cell.cartBtnOL.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControlEvents#>)
        }else if let products = productsSearchArray {
            let x = products[indexPath.row]
            cell.productSearchDetails = x
            cell.productImage.image = UIImage(named: "PlaceHolder")
            if x.image != "" , let url = URL(string: x.image ){
          
                cell.productImage.af_setImage(
                    withURL:url,
                    placeholderImage: UIImage(named: "PlaceHolder"),
                    filter: nil,
                    imageTransition: .crossDissolve(0.2)
                )
            }
            cell.downRightBtnOL.tag = indexPath.row
            cell.downRightBtnOL.addTarget(self, action: #selector(self.favButtonA(_:)), for: .touchUpInside)
            
            if favFuncsClass.saveFavData(x.name, x.price, x.image, x.id, state: nil){
                cell.isFav = true
//                print("that is the index :  \(indexPath.row) in row  : \(catIndexPath)")
            }else { cell.isFav = false }
        }
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsVC"  ) as! ProductDetailsVC
        if let products = productsArray {
               vc.product_id  = products[indexPath.row].id
        }else if let products = productsSearchArray {
             vc.product_id  = products[indexPath.row].id
        }
         self.navigationController?.pushViewController(vc, animated: true )
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
    
    
    func favButtonA(_ sender: UIButton) {
        if let products = productsSearchArray {
        let data = products[sender.tag]
            
        favFuncsClass.FavBtnAct(sender: sender, products[sender.tag].name, products[sender.tag].price, products[sender.tag].image, products[sender.tag].id  )
    }else if let products = productsArray {
            
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
