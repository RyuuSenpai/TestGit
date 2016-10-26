//
//  HomePagerExtension.swift
//  HyperApp
//
//  Created by Killvak on 25/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import UIKit


extension HomePageVC : UIScrollViewDelegate {
    
    func PromotionImageProtocoal(scrollView:UIScrollView) {
        
        scrollView.delegate = self
        
        for x in imagelist {
            scrollView.auk.show(image: x!)
        }
        scrollView.auk.startAutoScroll(delaySeconds: 3)
    }
    
    func tappedPromotionImg(scrollView:UIScrollView) {
        print("that is the index\(scrollView.auk.currentPageIndex)")
        print("Scroll view page ya man \(scrollView.currentPage)")
        let mySettings: PromotionVC = PromotionVC(nibName: "PromotionVC", bundle: nil)
        let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.flipHorizontal    /*.partialCurl */
        mySettings.modalTransitionStyle = modalStyle
        if let currentImageIndex = scrollView.auk.currentPageIndex {
            mySettings.promotionImageFlag = imagelist[currentImageIndex]
            
        }
        self.present(mySettings, animated: true, completion: nil)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == PromotionscrollView {
            PromotionscrollView.auk.stopAutoScroll()
            PromotionscrollView.auk.startAutoScroll(delaySeconds: 3)
        }
    }
    
    
}
