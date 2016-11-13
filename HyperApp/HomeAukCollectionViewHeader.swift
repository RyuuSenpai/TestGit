//
//  HomeAukCollectionViewHeader.swift
//  HyperApp
//
//  Created by Killvak on 10/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class HomeAukCollectionViewHeader: UICollectionReusableView  {
        
    @IBOutlet weak var promotionScrollView: UIScrollView!
    
    let imagelist = [UIImage(named:"0"),UIImage(named:"1"),UIImage(named:"2"),UIImage(named:"3"),UIImage(named:"4"),UIImage(named:"5")]

    
//@Auk
    static var theIndex : Int?
    override func awakeFromNib() {
        
        PromotionImageProtocoal(scrollView : promotionScrollView)
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
