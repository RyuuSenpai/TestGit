//
//  HomeCategoriesCell.swift
//  HyperApp
//
//  Created by Killvak on 21/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class HomeCategoriesCell: UICollectionViewCell , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UICollectionViewDelegate{
    
    
    @IBOutlet weak var categorytitle: UILabel!
    
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    var categoriesHomePageVC : HomePageVC?
    var catIndexPath  : Int?
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Best New Apps"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    override func awakeFromNib() {
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
       productsCollectionView.backgroundColor = UIColor.clear
    }

    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let   cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "HProductCell", for: indexPath) as! HomeProductCell
        cell.favButton.tag = indexPath.row
        cell.favButton.addTarget(self, action: #selector(HomeCategoriesCell.favButtonA(_:)), for: .touchUpInside)
        cell.addToCart.tag = indexPath.row
        cell.addToCart.addTarget(self, action: #selector(HomeCategoriesCell.cartButtonA(_:)), for: .touchUpInside)
        cell.share.tag = indexPath.row
        cell.share.addTarget(self, action: #selector(HomeCategoriesCell.shareButtonA(_:)), for: .touchUpInside)
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 234)
        
    }
    
    @IBAction func seeMore(_ sender: AnyObject) {
        
        
    }
    
     func favButtonA(_ sender: UIButton) {
        
        print("that is the button index : \(sender.tag)")

        selectedButton(sender: sender, selectedBtn: "heartitemenabled", disSelectImage: "heartitem")
    }
    
    func cartButtonA(_ sender: UIButton) {
        
        print("that is the button index : \(sender.tag)")

        selectedButton(sender: sender, selectedBtn: "carticon", disSelectImage: "cart")

    }
    
    func shareButtonA(_ sender: UIButton) {
        
        print("that is the button index : \(sender.tag)")
        selectedButton(sender: sender, selectedBtn: "favoriteditemenabled", disSelectImage: "favoriteditem")
    }
    
    
    
    func selectedButton( sender : UIButton , selectedBtn : String , disSelectImage : String) {
        sender.isSelected = !sender.isSelected
        if(sender.isSelected == true)
        {
            sender.setImage(UIImage(named:selectedBtn), for: UIControlState.normal)
        }
        else
        {
            sender.setImage(UIImage(named:disSelectImage), for: UIControlState.normal)
        }
    }
    
    // MARK: UICOllectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("selected Product")
        categoriesHomePageVC?.showProductDetailsVC(productDetails: indexPath.row, CatIndex: catIndexPath!)
    }
    
    
    
}



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
    
    
    override func awakeFromNib() {
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(1000.00) L.E")
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
preDiscountedPrice.attributedText = attributeString
    }


    
    

}
