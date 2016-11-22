//
//  HomeCategoriesCell.swift
//  HyperApp
//
//  Created by Killvak on 21/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit
import CoreData


class HomeCategoriesCell: UICollectionViewCell , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UICollectionViewDelegate{
    
    
    
    
    @IBOutlet weak var seeMore: UIButton!
    @IBOutlet weak var categorytitle: UILabel!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    var productCategory : ProductCategories? {
        didSet {
            if let categoryTitle = productCategory?.name {
                categorytitle.text = categoryTitle
            }
        }
    }
    
    var coredataClass = CoreDataProductFunctions()
    
    
    
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
        if coredataClass.checkIfFav(data: productCategory?.products?[indexPath.row]){
            cell.isFav = true
        }
        if coredataClass.checkIfOncart(data: productCategory?.products?[indexPath.row]){
            cell.onCart = true
        }
        cell.products = productCategory?.products?[indexPath.item]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 234)
        
    }
    
    
    
    
    
    func favButtonA(_ sender: UIButton) {
        
        print("that is the button index : \(sender.tag)")
        
        
        selectedButton(sender: sender, selectedBtn: "heart_icon_selected", disSelectImage: "Heart_icon")
        
        
        
        
    }
    
    func cartButtonA(_ sender: UIButton) {
        
        print("that is the button index : \(sender.tag)")
        
        selectedButton(sender: sender, selectedBtn: "carticon", disSelectImage: "cart")
        
    }
    
    func shareButtonA(_ sender: UIButton) {
        
        print("that is the button index : \(sender.tag)")
        let data = productCategory?.products?[sender.tag]
        
        categoriesHomePageVC?.shareItems(sender : sender , data: data)
        
    }
    
    
    
    func selectedButton( sender : UIButton , selectedBtn : String , disSelectImage : String) {
        sender.isSelected = !sender.isSelected
        let shareImage = "favoriteditemenabled"
        let data = productCategory?.products?[sender.tag]
        
        if(sender.isSelected == true)
        {
            sender.setImage(UIImage(named:selectedBtn), for: UIControlState.normal)
            if selectedBtn == "carticon" {
                
                
                
                
                let fetchRequest : NSFetchRequest<CDOnCart> = CDOnCart.fetchRequest()
                let  predicate = NSPredicate(format: "name == %@", (data?.name)!)
                fetchRequest.predicate = predicate
                do {
                    let fetcjResult = try context.fetch(fetchRequest)
                    if fetcjResult.count > 0 {
                        print("Already Fav")
                    }else {
                        
                        let CartItem = CDOnCart(context: context)
                        context.mergePolicy = CartItem
                        CartItem.name  = data?.name
                        CartItem.quantity = 1
                        if let price = data?.price {
                            CartItem.price = price
                        }else { print("error in price in HomeCat save onCart")}
                        ad.saveContext()
                        print("saved data")
                        categoriesHomePageVC?.cartNumberOfItemsBadge()
                    }
                } catch let error as NSError {
                    print("That is the error in FavListCoreData : \(error.localizedDescription)")
                }
                
                
            }else if selectedBtn ==  shareImage {
                
                
            }else {
                let data = productCategory?.products?[sender.tag]
                
                let fetchRequest : NSFetchRequest<CDFavList> = CDFavList.fetchRequest()
                print("that is hte shit id : \((data?.id)!)"   )
                let  predicate = NSPredicate(format: "name == %@", (data?.name)!)
                fetchRequest.predicate = predicate
                do {
                    
                    
                    let fetcjResult = try context.fetch(fetchRequest)
                    if fetcjResult.count > 0 {
                        print("Already Fav")
                    }else {
                        
                        let favItem = CDFavList(context: context)
                        context.mergePolicy = favItem
                        favItem.name  = data?.name
                        ad.saveContext()
                        print("saved data")
                    }
                } catch let error as NSError {
                    print("That is the error in FavListCoreData : \(error.localizedDescription)")
                }
            }
        }
        else
        {
            sender.setImage(UIImage(named:disSelectImage), for: UIControlState.normal)
            
            if selectedBtn == "carticon" {
                
                let fetchRequest : NSFetchRequest<CDOnCart> = CDOnCart.fetchRequest()
                let  predicate = NSPredicate(format: "name == %@", (data?.name)!)
                fetchRequest.predicate = predicate
                do {
                    
                    
                    let fetcjResult = try context.fetch(fetchRequest)
                    if fetcjResult.count > 0 {
                        print("Already Fav")
                        print("will delete : \((data?.name)!)")
                        context.delete(fetcjResult[0])
                        ad.saveContext()
                        categoriesHomePageVC?.cartNumberOfItemsBadge()
                    }
                }catch {
                    print("Fetching failed")
                }
                
            }else  if selectedBtn == shareImage {
                
            } else {
                
                let fetchRequest : NSFetchRequest<CDFavList> = CDFavList.fetchRequest()
                let  predicate = NSPredicate(format: "name == %@", (data?.name)!)
                fetchRequest.predicate = predicate
                do {
                    
                    
                    let fetcjResult = try context.fetch(fetchRequest)
                    if fetcjResult.count > 0 {
                        print("Already Fav")
                        print("will delete : \((data?.name)!)")
                        context.delete(fetcjResult[0])
                        ad.saveContext()
                    }
                }catch {
                    print("Fetching failed")
                }
                
            }
        }
    }
    
    
    
    // MARK: UICOllectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("selected Product")
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
        }
    }


    override func awakeFromNib() {
        
        
    }
    
    
    
    
    
}
