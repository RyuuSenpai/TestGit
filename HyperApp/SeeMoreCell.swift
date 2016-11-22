//
//  SeeMoreCell.swift
//  HyperApp
//
//  Created by Killvak on 16/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class SeeMoreCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var discountViewContainer: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var preDIscountPrice: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var addToCartBtn: UIButton!
    

    func configCell(product : productDetails?){
        
        if let name = product?.name {
            title.text = name
        }//title
        if let pricee = product?.price{
            price.text = "\(pricee) L.E"
        }//price
        
    }
}
