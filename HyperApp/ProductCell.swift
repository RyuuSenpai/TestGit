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
    private     let favFuncsClass = FavItemsFunctionality()
    private      let onCartFuncsClass = OnCartFunctionality()
 
    var isFav = false {
        didSet {
            if isFav {
                self.downRightBtnOL?.setImage(#imageLiteral(resourceName: "heart_icon_selected"), for: .normal)
                downRightBtnOL.isSelected = true

            }else {
                self.downRightBtnOL?.setImage(#imageLiteral(resourceName: "Heart_icon"), for: .normal)
                  downRightBtnOL.isSelected = false 
            }
        }
    }
    
    var isOnCart = false {
        didSet {
            if isOnCart {
                self.cartBtnOL?.setImage(#imageLiteral(resourceName: "carticon"), for: .normal)
                cartBtnOL.isSelected = true
                
            }else {
                self.cartBtnOL?.setImage(#imageLiteral(resourceName: "cart"), for: .normal)
                cartBtnOL.isSelected = false
            }
        }
    }
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
            guard let data = productDetails else { return }

            if let title = data.name {
                prTitle.text = title
            }
            if let price = data.price {
                self.pricelbl.text = "\(price) L.E"
            }
            if let prePrice = data.price {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(prePrice) L.E")
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                discountedPriceLbl.attributedText = attributeString
            }
            
            if let img =  data.image_pr {
              productImage.image = img
            }else   if let img =  data.image_url  , img != "" , let url = URL(string: img ){
                productImage.af_setImage(
                    withURL:url,
                    placeholderImage: UIImage(named: "PlaceHolder"),
                    filter: nil,
                    imageTransition: .crossDissolve(0.2)
                )

             }
            checkifFav(data.name ?? "", data.price ?? 0.0, data.image_url ?? "", data.id ?? 0 )
            if onCartFuncsClass.saveCartData(data: onCartFuncsClass.transferDataToCartObj(data: data) , state: nil){
                isOnCart = true
            }else { isOnCart = false }
        }
    }

    var productSearchDetails :  Search_Data? {
        
        didSet {
            guard let data = productSearchDetails else { return }
                 prTitle.text = data.name
                           self.pricelbl.text = "\(data.price ) L.E"
                 let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(data.price) L.E")
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                discountedPriceLbl.attributedText = attributeString
  
             if  data.image != "" , let url = URL(string: data.image ){
                productImage.af_setImage(
                    withURL:url,
                    placeholderImage: UIImage(named: "PlaceHolder"),
                    filter: nil,
                    imageTransition: .crossDissolve(0.2)
                )
                
             }else {
                productImage.image = UIImage(named: "PlaceHolder")
            }
            
            checkifFav(data.name, data.price, data.image, data.id)
            
            if onCartFuncsClass.saveCartData(data: onCartFuncsClass.transSearch_DataToCartObj(data: data) , state: nil){
                isOnCart = true
            }else { isOnCart = false }
        }
    }
    
    func checkifFav(_ name : String,_ price :Double,_ image :String,_ id : Int ) {
        if favFuncsClass.saveFavData(name, price, image, id, state: nil){
            isFav = true
            //                print("that is the index :  \(indexPath.row) in row  : \(catIndexPath)")
        }else { isFav = false }
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
