//
//  FavItemCell.swift
//  HyperApp
//
//  Created by Killvak on 01/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class FavItemsCell: UICollectionViewCell{
    
    @IBOutlet weak var discountVIew: UIView!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var discountPrecent: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var preDiscountPrice: UILabel!
    
    
    
    @IBOutlet weak var removeFromFav: UIButton!
    
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var addToCart: UIButton!
    
    var favItem : CDFavList? {
        didSet {
            
            if let title = favItem?.name {
                productTitle.text = title
            }
//            if let price = productDetails?.price {
//                self.price.text = "\(price)"
//            }
//            if let prePrice = productDetails?.preDiscountPrice {
//                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(prePrice) L.E")
//                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
//                preDiscountPrice.attributedText = attributeString
//            }
            
//        }
    }
    }
    
    var productDetails :  productDetails? {
        
        didSet {
            
            if let title = productDetails?.name {
                productTitle.text = title
            }
            if let price = productDetails?.price {
                self.price.text = "\(price)"
            }
            if let prePrice = productDetails?.preDiscountPrice {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(prePrice) L.E")
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                preDiscountPrice.attributedText = attributeString
            }
            
        }
    }
}
