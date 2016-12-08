//
//  File.swift
//  HyperApp
//
//  Created by Killvak on 06/12/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation


class HomeProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var preDiscountedPrice: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var catNum : Int?
    var isFav = false
    var onCart = false
    
    
    func configCell(products :productDetails?){
        
        
        if let title = products?.name {
            self.productTitle.text = title
        }else {  self.productTitle.text = nil}
        
        if let price = products?.price {
            self.productPrice.text = "\(price)"
        }else { self.productPrice.text = nil }
        
        if let prePrice = products?.preDiscountPrice {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(prePrice) L.E")
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            self.preDiscountedPrice.attributedText = attributeString
        }else { self.preDiscountedPrice.attributedText = nil }
        if let id =  products?.id_parent {
            self.discountLabel.text = "\(id)"
        }else {  self.discountLabel.text = nil }
        if self.isFav {
            self.favButton.setImage(UIImage(named:"heart_icon_selected"), for: UIControlState.normal)
            self.favButton.isSelected = true
        }else {
            self.favButton.setImage(UIImage(named:"Heart_icon"), for: UIControlState.normal)
            self.favButton.isSelected = false
            
        }
        if self.onCart {
            self.addToCart.setImage(UIImage(named:"carticon"), for: UIControlState.normal)
            self.addToCart.isSelected = true
        }else {
            self.addToCart.setImage(UIImage(named:"cart"), for: UIControlState.normal)
            self.addToCart.isSelected = false
        }
        self.productImage.image = #imageLiteral(resourceName: "PlaceHolder")
                if let imageString = products?.image_url {
                    DispatchQueue.global(qos: .userInteractive).async { () -> Void in
                        let imageUrl = URL(string: imageString)
                        guard let url = imageUrl , let imageData = try? Data(contentsOf: url) else { return }
                        let image = UIImage(data: imageData )
        
        
        
                        DispatchQueue.main.async(execute: { () -> Void in
                            if self.tag == self.catNum {
        
                                self.productImage.image = image
                            }})
        
                    }
                }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productImage.image = #imageLiteral(resourceName: "PlaceHolder")
        productTitle.text = nil
        productPrice.text = nil
        discountLabel.text = nil
        preDiscountedPrice.text = nil
        favButton.setImage(UIImage(named:"Heart_icon"), for: UIControlState.normal)
        addToCart.setImage(UIImage(named:"cart"), for: UIControlState.normal)
        
    }
    
    func getImage(completionHandler handler : @escaping (_ image : UIImage) -> Void) {
        
        
    }
    override func awakeFromNib() {
        print("that is the cell tag \(self.tag) and that is the row number : \(catNum)")
        print("--------------------------------")
        
    }
    
    
    
    
}
