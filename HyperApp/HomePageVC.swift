//
//  HomePageVC.swift
//  HyperApp
//
//  Created by Killvak on 18/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController  , UIScrollViewDelegate   , UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var PromotionscrollView: UIScrollView!
    @IBOutlet weak var categoriesContainerView: UIView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!

    @IBOutlet weak var mainProductsRow: UICollectionView!

    
    private let reuseIdentifier = "CategoriesCell"

    
    
        let imagelist = [UIImage(named:"0"),UIImage(named:"1"),UIImage(named:"2"),UIImage(named:"3"),UIImage(named:"4"),UIImage(named:"5")]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.PromotionscrollView.delegate = self
        
        for x in imagelist {
            PromotionscrollView.auk.show(image: x!)
        }
        PromotionscrollView.auk.startAutoScroll(delaySeconds: 3)
    
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        mainProductsRow.delegate = self
        mainProductsRow.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tappedPromotionImage(_ sender: AnyObject) {
        print("that is the index\(PromotionscrollView.auk.currentPageIndex)")
        print("Scroll view page ya man \(PromotionscrollView.currentPage)")
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == PromotionscrollView {
        PromotionscrollView.auk.stopAutoScroll()
        PromotionscrollView.auk.startAutoScroll(delaySeconds: 3)
        }
    }


    @IBAction func searchGesture(_ sender: AnyObject) {
        print("Search clicked")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: UICOllectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if collectionView == self.categoriesCollectionView {
            return 9
        }else {
        return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.categoriesCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        // Configure the cell  RowCell
            return cell

        } else  {
            let   cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "RowCell", for: indexPath) as! HomeCategoriesCell
            return cell

        }
    }
    
    // MARK: UICOllectionViewLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.categoriesCollectionView {

        if indexPath.row == 0 {
            return CGSize(width: 180, height: 180) // The size of one cell
        }else {
            return CGSize(width: 102, height: 102) // The size of one cell
        }
        }else {
            
            return CGSize(width: self.mainProductsRow.frame.width, height:264)
//            return CGSize(width: self.mainProductsRow.frame.width, height: view.frame.height * 0.25)
        }
    }

}
