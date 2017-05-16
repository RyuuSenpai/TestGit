//
//  HomeAukCollectionViewHeader.swift
//  HyperApp
//
//  Created by Killvak on 10/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HomeAukCollectionViewHeader: UICollectionReusableView ,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var promotionScrollView: UIScrollView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var productsBrands : ProductCategories?
    var brands : [GetAllBrandsModel]?
    
    let imagelist = [UIImage(named:"0"),UIImage(named:"1"),UIImage(named:"2"),UIImage(named:"3"),UIImage(named:"4"),UIImage(named:"5")]
    
    
    //@Auk
    static var theIndex : Int?
    override func awakeFromNib() {
        PromotionImageProtocoal(scrollView : promotionScrollView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        productsBrands = ProductCategories()
        brands = [GetAllBrandsModel]()
        productsBrands?.getAllBrandsData(pageNum: 2, compeleted: { [weak self ] (data) in
            
            print("that's the finaly data : \(data)")
            self?.brands = data
            self?.collectionView.reloadData()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = brands?.count   else { return 0 }
        return count  
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryActivityCell", for: indexPath) as! CategoryActivityCell
        guard let data = brands , data.count > 0   else { return cell }
//        if data.count    == indexPath.row {
//            cell.seeMore.alpha = 1
//            cell.catImage.alpha = 0 
//        return cell
//        }
        print("thati's idex : \( data.count ) count : \( indexPath.row )")
        print("that's the Get All Brands image URL : \(IMAGE_HOME_PATH + data[indexPath.row].image)")
   cell.seeMore.alpha = 0
        cell.catImage.af_setImage(
            withURL: URL(string: IMAGE_HOME_PATH + data[indexPath.row] .image )!,
            placeholderImage: UIImage(named: "PlaceHolder"),
            filter: nil,
            imageTransition: .crossDissolve(0.2)
        )
        return cell
    }
    //@Delete
    
    
}

import Foundation
import UIKit


extension HomeAukCollectionViewHeader : UIScrollViewDelegate {
    
    func PromotionImageProtocoal(scrollView:UIScrollView) {
        
        scrollView.delegate = self
        
        for x in imagelist {
            scrollView.auk.show(image: x!)
        }
        scrollView.auk.startAutoScroll(delaySeconds: 3)
    }
    
    
    
    
    //    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    //        HomeAukCollectionViewHeader.theIndex = promotionScrollView.auk.currentPageIndex
    //    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == promotionScrollView {
            promotionScrollView.auk.stopAutoScroll()
            promotionScrollView.auk.startAutoScroll(delaySeconds: 3)
        }
    }
    
    //@Auk
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        HomeAukCollectionViewHeader.theIndex = self.promotionScrollView.auk.currentPageIndex
        
        
    }
}

class CategoryActivityCell : UICollectionViewCell {
    
    @IBOutlet weak var catImage: UIImageView!
    
    @IBOutlet weak var seeMore: UILabel!
    
    
    
    
}
