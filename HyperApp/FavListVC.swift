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
class FavListVC: UIViewController  , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    let home = HomeCategoriesCell()
    var favList : [CDFavList]?
    var favImages : [UIImage]!
    var productCatData : ProductCategories!

     var isnotSubV = true

    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.view.squareLoading.start(0.0)

      
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        self.revealMenu()
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

    
    func getImage(image:String) ->UIImage {
        
        let imageURL = URL(string: image)
        if let imageData = NSData(contentsOf: imageURL!){
            return UIImage(data: imageData as Data)!
        }
        return #imageLiteral(resourceName: "PlaceHolder")
        
    }
    
    func revealMenu() {
        
        if isnotSubV {
            
        
        if self.revealViewController() != nil {
            let sideMenuBtn = UIBarButtonItem(image: UIImage(named: "browsebutton"), style: .plain, target: self.revealViewController(), action: #selector(getter: UIDynamicBehavior.action)) // action:#selector(Class.MethodName) for swift 3
            
            self.navigationItem.leftBarButtonItem  = sideMenuBtn
            sideMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            //                 self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            //            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        }
        isnotSubV = true

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
        cell.imageData = favImages?[indexPath.row]
        cell.favItem = favList?[indexPath.row]
        cell.removeFromFav.layer.setValue(indexPath.row, forKey: "index")
        cell.removeFromFav.tag = indexPath.row
        cell.removeFromFav.addTarget(self, action: #selector(removeFav(sender:)) , for: .touchUpInside)

        return cell
    }
    
    
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
        var height  :CGFloat = 229.0
        var width : CGFloat = 160.0
        if (self.view.frame.size.width * 0.45) > width {
            width = (self.view.frame.size.width * 0.45)
        }
        if (width * 1.43) > height {
            height = (width * 1.43)
        }
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
