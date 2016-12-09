//
//  CartVC.swift
//  HyperApp
//
//  Created by Killvak on 01/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//
import Foundation
import UIKit
import RealmSwift
import Alamofire
class FavListVC: UIViewController  , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {

    @IBOutlet weak var collectionView: UICollectionView!
    let home = HomeCategoriesCell()
    var favList : [CDFavList]?
    var favImages : [UIImage]!
    var productCatData : ProductCategories!
let getImageClass = GetImage()
     var isnotSubV = true

    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.view.squareLoading.start(0.0)

      
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        if isnotSubV {

        self.revealMenu()
        }
        isnotSubV = true 
//     productCatData = ProductCategories()
//        productCatData.getFavImageFromCD(mainFavList: { (list) in
//            
//            print("Done with getting the Images")
//            self.favList = list
//            }) { (images ) in
//                
//                self.favImages = [UIImage]()
//                self.favImages = images
//                self.view.squareLoading.stop(0.0)
//                self.revealMenu()
//                self.collectionView.reloadData()
//        }
 getTheData()
    }

    
  
    
   
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = favList?.count else {
            return 0
        }
        return count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavItemsCell", for: indexPath) as! FavItemsCell
        cell.favItem = favList?[indexPath.row]
        cell.removeFromFav.layer.setValue(indexPath.row, forKey: "index")
        cell.removeFromFav.tag = indexPath.row
        cell.removeFromFav.addTarget(self, action: #selector(removeFav(sender:)) , for: .touchUpInside)
        cell.productImage.image = #imageLiteral(resourceName: "PlaceHolder")
        getImageClass.getFavListImages(data: favList?[indexPath.row]) { (img) in
            cell.productImage.image = img
        }
            if let item = self.favList?[indexPath.row] {
                  if let imageData = item.imageData {
                    cell.productImage.image = UIImage(data: imageData)
                  }else {
                    getImageClass.downloadImage(favItem: favList?[indexPath.row]) { (data) in
                        if cell.tag == indexPath.row {
                            
                            cell.productImage.image = UIImage(data: data)
                        }
                        do {
                            let realm = try Realm()
                            
                            try realm.write{
                                item.imageData = data
                            }
                        } catch let err as NSError {
                            print(err)
                        }
                    }
                }
        }//

        return cell
    }
    /*
     if let item = items?[indexPath.row] {
     
     cell.tag = indexPath.row
     if item.imageData == nil {
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
     }else {
     cell.productImage.image = UIImage(data: item.imageData!)
     }
     
     }
 */
    
    
    func getTheData() {
        do {
            let realm = try Realm()
            let favL = realm.objects(CDFavList.self)
            favList = [CDFavList]()
            for y in favL {
                favList?.append(y)
            }
            collectionView.reloadData()
        }catch let err as NSError {
            print("that is error ya man   :   \(err)")
        }
        
    }
    
    func removeFav(sender:UIButton) {
       
        do {
            let realm = try Realm()
            let objectD = ((favList?[sender.tag])!)
            print("will deleet : \(objectD)")
            realm.beginWrite()
            realm.delete(objectD)
           try  realm.commitWrite()
            getTheData()
        }catch let err as NSError {
            print("that is error ya man   :   \(err)")
        }
        
    }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height  :CGFloat = (self.view.frame.size.width * 0.43) * 1.5
        let width : CGFloat = self.view.frame.size.width * 0.43
        print("that is the not fixed width \(self.view.frame.size.width * 0.45)")
//        if (self.view.frame.size.width * 0.45) > width {
//            width = (self.view.frame.size.width * 0.40)
//        }
//        if (width * 1.43) > height {
//            height = (width * 1.43)
//        }
        print("that is the not fixed width \(width)")
        print("that is the not fixed height \(height)")

        return CGSize(width: width , height: height) // The size of one cell
        
            //            return CGSize(width: self.mainProductsRow.frame.width, height: view.frame.height * 0.25)
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
