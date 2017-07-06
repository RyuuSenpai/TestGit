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

   private   let onCartFuncsClass = OnCartFunctionality()
    let favFuncsClass = FavItemsFunctionality()

    var isSeemore = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ProductCell.nib, forCellWithReuseIdentifier: ProductCell.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        guard productsSearchArray == nil else {
//            self.getImageProductDetails()
            self.collectionView?.reloadData()
            return
        }
        self.view.squareLoading.start(0.0)
          postRequest = PostRequests()
        
        if catID == nil {
            
            catID = productCatSelected?.catDetails?.id
        } 
//        print("that is the cat id : \(catID)")
        postRequest?.getCatProductsDetailsData(catID: catID, completed: { [weak self ](productsArray) in

            self?.productsArray = productsArray
            DispatchQueue.main.async {
                guard let data = productsArray , data.count > 0 else {
                 SweetAlert().showAlert("No Data To Present")
                    self?.navigationController?.pop(animated: true)
                    return
                }
                self?.view.squareLoading.stop(0.0)
//                self?.getImageProductDetails()
                self?.collectionView.reloadData()
            }
            

        })
        
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ad.cancelAllAlamnofireNetRequests()
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
   
        
        if let seeMoreProducts = productsArray {
            cell.productDetails = seeMoreProducts[indexPath.row]
          }else  if let products = productsSearchArray {
             cell.productSearchDetails = products[indexPath.row]
         }
        cell.cartBtnOL.tag = indexPath.row
        cell.cartBtnOL.addTarget(self, action: #selector(HomeCategoriesCell.cartButtonA(_:)), for: .touchUpInside)


        
        cell.downRightBtnOL.tag = indexPath.row
        cell.downRightBtnOL.addTarget(self, action: #selector(self.favButtonA(_:)), for: .touchUpInside)

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
    
//    func getImageProductDetails() {
//        guard let data = productsArray else { return }
//        for pd in data {
//            guard let imgStrUrl = pd.image_url else {return }
//            Alamofire.request(imgStrUrl).responseImage { response in
//                debugPrint(response)
//                
////                print(response.request)
////                print(response.response)
//                debugPrint(response.result)
//                
//                if let image = response.result.value {
//                    print("image downloaded: \(image)")
//                    pd.image_pr = image
//                    self.collectionView.reloadData()
//                }
//            }
//        }
//    }
    
    
    func favButtonA(_ sender: UIButton) {
        
        if let products = productsSearchArray {
        let data = products[sender.tag]
            
        favFuncsClass.FavBtnAct(sender: sender, products[sender.tag].name, products[sender.tag].price, products[sender.tag].image, products[sender.tag].id  )
    }else if let products = productsArray {
            let data = products[sender.tag]
            
            favFuncsClass.FavBtnAct(sender: sender, products[sender.tag].name, products[sender.tag].price, products[sender.tag].image_url, products[sender.tag].id  )
         }
    }
    
    func cartButtonA(_ sender: UIButton) {
        
        if let products = productsSearchArray {
            let data = products[sender.tag]
            
            onCartFuncsClass.cartBtnAct(sender: sender, data: onCartFuncsClass.transSearch_DataToCartObj(data: data) ,buyNow : false)
        }else if let products = productsArray {
            let data = products[sender.tag]
             onCartFuncsClass.cartBtnAct(sender: sender, data: onCartFuncsClass.transferDataToCartObj(data: data) ,buyNow : false)

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
    @IBAction func filterBtnAct(_ sender: UIButton) {
        
        let vc = FilterVC(nibName: "FilterVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
