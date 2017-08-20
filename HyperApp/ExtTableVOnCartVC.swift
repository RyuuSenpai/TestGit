//
//  ExtTableVOnCartVC.swift
//  HyperApp
//
//  Created by Killvak on 16/01/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


extension OnCartVC : UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let items = items else {
                return
            }
            let item = items[indexPath.row]
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.delete(item)
                try realm.commitWrite()
                
//                if self.items?[indexPath.row] == item  {
//                    self.items?.remove(object: item)
//                }
                getTheData()
                
            }catch let err as NSError {
                print("error while deleting Row OnCart rror  : \(err)")
            }
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 240.0;//Choose your custom row height
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
            
            if let productData = self.items?[indexPath.row] {
                
                let productDetailController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
                
                let y  = Convertor()
                let productDetails = y.CartListToProductList(data: productData)
                productDetailController.products = productDetails
                productDetailController.product_id = productDetails?.id
                
                
                navigationController?.pushViewController(productDetailController, animated: true)
                
            }
        }
}

import Alamofire
import AlamofireImage

extension OnCartVC : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = items?.count else {
            return 0
        }
        return count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OnCartCell
        cell.tag = indexPath.row
        cell.deleteRowDataBtn.tag = indexPath.row
        cell.addToQuantity.tag = indexPath.item
        cell.removeFromQuantity.tag = indexPath.item
        
        cell.onCart = items?[indexPath.row]
        
        cell.removeFromQuantity.addTarget(self, action: #selector(subtractFromQuantity(sender:)) , for: UIControlEvents.touchUpInside)
        cell.addToQuantity.addTarget(self, action: #selector(addToQuantity(sender:)) , for: UIControlEvents.touchUpInside)
        
        
        
        cell.deleteRowDataBtn.setImage( #imageLiteral(resourceName: "checkBox√"), for: UIControlState.selected)
        cell.deleteRowDataBtn.setImage(#imageLiteral(resourceName: "uncheckBox"), for: UIControlState.normal)
        
        //        if cell.tag == indexPath.row {
        cell.deleteRowDataBtn.addTarget(self, action: #selector(buttonClicked(_:)), for: UIControlEvents.touchUpInside)
        do {
            cell.deleteRowDataBtn.isSelected = try filledHeartSet.contains( indexPath as NSIndexPath)
        } catch (let err as NSError) {
            
        }
        //        }
        if self.editNavBtn.title == "Done" {
            cell.deleteRowDataBtn.isHidden = false
        }else {
            cell.deleteRowDataBtn.isHidden = true
        }
 
        print("debugging : \(items?[indexPath.row])")
        if let item = items?[indexPath.row] {
            
            if item.imageData == nil {
                cell.productImage.af_setImage(
                    withURL: URL(string: item.imgString )!,
                    placeholderImage: UIImage(named: "PlaceHolder"),
                    filter: nil,
                    imageTransition: .crossDissolve(0.2)
                )
                /*
                downloadImage(index: indexPath.row, completionHandler: { (data) in
                    if cell.tag == indexPath.row {
                        
                        cell.productImage.image = UIImage(data: data)
                    }
                    do {
                        let realm = try Realm()
                        guard let item = self.items?[indexPath.row] else { return }
                        
                        try realm.write{
                            item.imageData = data
                        }
                    } catch let err as NSError {
                        print(err)
                    }
                })
           */ }else {
                if let imageData  = item.imageData {
                    cell.productImage.image = UIImage(data: imageData )
                }
            }
        }
        return cell
        
    }
    
}

