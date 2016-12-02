//
//  HomeCategoriesCell.swift
//  HyperApp
//
//  Created by Killvak on 21/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit
import RealmSwift 

class HomeCategoriesCell: UICollectionViewCell , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UICollectionViewDelegate{
    
    
    
    
    @IBOutlet weak var seeMore: UIButton!
    @IBOutlet weak var categorytitle: UILabel!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    let favFuncsClass = FavItemsFunctionality()
    let onCartFuncsClass = OnCartFunctionality()
    var productCategory : ProductCategories? {
        didSet {
            if let categoryTitle = productCategory?.name {
                categorytitle.text = categoryTitle
            }
        }
    }
    
 //   var coredataClass = CoreDataProductFunctions()
    
    
    
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
        recivedNotification()

        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.backgroundColor = UIColor.clear
    }
    
    func recivedNotification() {
        NotificationCenter.default.addObserver(forName: REFRESH_HOMEPAGE_CELLS, object: nil, queue: nil) { notification  in
            //            let largerCell = HomeCategoriesCell()
            //            largerCell.reloadData()
            
            self.productsCollectionView.reloadData()
            print("recivedNotification : \(notification)")
        }
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
     func reloadData() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4.9) {
//            }
        perform(#selector(HomeCategoriesCell.Test), with: nil, afterDelay: 2)
    }
    func Test() {
    print("YAY")
//        self.productsCollectionView.reloadData()
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = productCategory?.products?.count {
            return count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let   cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "HProductCell", for: indexPath) as! HomeProductCell
        cell.favButton.tag = indexPath.row
        cell.favButton.addTarget(self, action: #selector(HomeCategoriesCell.favButtonA(_:)), for: .touchUpInside)
        cell.addToCart.tag = indexPath.row
        cell.addToCart.addTarget(self, action: #selector(HomeCategoriesCell.cartButtonA(_:)), for: .touchUpInside)
        cell.share.tag = indexPath.row
        cell.share.addTarget(self, action: #selector(HomeCategoriesCell.shareButtonA(_:)), for: .touchUpInside)
        if favFuncsClass.saveFavData(data: productCategory?.products?[indexPath.row], state: nil){
            cell.isFav = true
        }else { cell.isFav = false }
        if onCartFuncsClass.saveCartData(data: productCategory?.products?[indexPath.row], state: nil){
            cell.onCart = true
        }else { cell.onCart = false }
        cell.products = productCategory?.products?[indexPath.item]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 234)
        
    }
    
 
  
    func favButtonA(_ sender: UIButton) {
        let data = productCategory?.products?[sender.tag]

       favFuncsClass.FavBtnAct(sender: sender, data: data )
    }
    
    func cartButtonA(_ sender: UIButton) {
        let data = productCategory?.products?[sender.tag]

        onCartFuncsClass.cartBtnAct(sender: sender, data: data,buyNow : false)
    }
    
    func shareButtonA(_ sender: UIButton) {
        
        print("that is the button index : \(sender.tag)")
        let data = productCategory?.products?[sender.tag]
        
        categoriesHomePageVC?.shareItems(sender : sender , data: data)
        
    }
    
   
    
    // MARK: UICOllectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if saveCartData(data: productCategory?.products?[indexPath.row], state: nil){
//            print("selected Product and teh state is √")
//
//        }else {
//            print("selected Product and teh state is X ")
//
//        }
        let data = productCategory?.products?[indexPath.row]
        
        categoriesHomePageVC?.showProductDetailsVC(productDetails: indexPath.row, CatIndex: catIndexPath!, product : data)
    }
    
    
    //Test
    
    
    
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
    
    var isFav = false
    var onCart = false
    var products : productDetails? {
        didSet {
            if let title = products?.name {
                productTitle.text = title
            }
            if let price = products?.price {
                productPrice.text = "\(price)"
            }
            if let prePrice = products?.preDiscountPrice {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(prePrice) L.E")
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                preDiscountedPrice.attributedText = attributeString
            }
            if let id =  products?.id_parent {
                discountLabel.text = "\(id)"
            }
            if isFav {
                favButton.setImage(UIImage(named:"heart_icon_selected"), for: UIControlState.normal)
                favButton.isSelected = true
            }else {
                favButton.setImage(UIImage(named:"Heart_icon"), for: UIControlState.normal)
                favButton.isSelected = false

            }
            if onCart {
                addToCart.setImage(UIImage(named:"carticon"), for: UIControlState.normal)
                addToCart.isSelected = true
            }else {
                addToCart.setImage(UIImage(named:"cart"), for: UIControlState.normal)
            addToCart.isSelected = false
            }
            
            if let imageUrl = products?.image_pr {
                productImage.image = imageUrl
            }
        }
    }


    override func awakeFromNib() {
        
        
    }

    
    
    
}
