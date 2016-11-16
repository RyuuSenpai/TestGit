//
//  CartVC.swift
//  HyperApp
//
//  Created by Killvak on 01/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//
import Foundation
import UIKit
import CoreData
import Alamofire
class FavListVC: UIViewController  , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var sideMenuBOL: UIBarButtonItem!

    @IBOutlet weak var collectionView: UICollectionView!
    let home = HomeCategoriesCell()
    var favList : [CDFavList]?
    
    var fhp : FHP!
    var almno = [FHP]()
    override func viewWillAppear(_ animated: Bool) {
        getTheData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            sideMenuBOL.target = self.revealViewController()
            sideMenuBOL.action = #selector(SWRevealViewController.revealToggle(_:))
            //     self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        fhp = FHP()
        fhp.downloadHomePageData { (almno) in
            print(almno.count)
            for x in (almno[0].productsList)! {
                print(x.id)
                
            }
            print(almno[1].catName )
            for x in (almno[1].productsList)! {
                print(x.id)
            
            }
        }
        
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
        cell.removeFromFav.addTarget(self, action: #selector(removeFav(sender:)) , for: .touchUpInside)

        
        return cell
    }
    
    func removeFav(sender:UIButton) {
          let i : Int = (sender.layer.value(forKey: "index")) as! Int
        guard let fav = favList else {
            return
        }
        let deletedObject = fav[i]
        context.delete(deletedObject)
        ad.saveContext()
        getTheData()
        
    }
    
    func getTheData() {
        
        do {
            
            favList = try context.fetch(CDFavList.fetchRequest())
            
        }catch {
            print("Fetching failed")
        }
        collectionView.reloadData()
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
