//
//  RelatedItemsProductDetailsVCCell.swift
//  HyperApp
//
//  Created by Killvak on 26/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class RelatedItemsProductDetailsVCCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var preDiscountPrice: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var addToCartBtn: UIButton!
}
