//
//  ProductCell.swift
//  HyperApp
//
//  Created by Killvak on 27/12/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var discountViewOL: UIView!
    @IBOutlet weak var discountPercentOL: UILabel!
    @IBOutlet weak var prTitle: UILabel!
    @IBOutlet weak var discountedPriceLbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var cartBtnOL: UIButton!
    @IBOutlet weak var downRightBtnOL: UIButton!
    @IBOutlet weak var shareBtnOL: UIButton!
    
    
    override func prepareForReuse() {
        self.productImage.image = #imageLiteral(resourceName: "PlaceHolder")
    }
    
    var favItem : CDFavList? {
        didSet {
            
            if let title = favItem?.name {
                prTitle.text = title
            }
            if let price = productDetails?.price {
                self.pricelbl.text = "\(price) L.E"
            }
            //            if let prePrice = productDetails?.preDiscountPrice {
            //                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(prePrice) L.E")
            //                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            //                preDiscountPrice.attributedText = attributeString
            //            }
            
            //        }
        }
    }
    var productDetails :  ProductDetails? {
        
        didSet {
            
            if let title = productDetails?.name {
                pricelbl.text = title
            }
            if let price = productDetails?.price {
                self.pricelbl.text = "\(price) L.E"
            }
            if let prePrice = productDetails?.preDiscountPrice {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(prePrice) L.E")
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                discountedPriceLbl.attributedText = attributeString
            }
            
        }
    }

            
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    class var identifier: String {
        return String(describing: self)
    }
    
}