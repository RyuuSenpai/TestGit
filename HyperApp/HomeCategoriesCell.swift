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
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productsCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = productCategory?.products?.count {
            return count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.row)
        let   cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "HProductCell", for: indexPath) as! HomeProductCell
        cell.tag = indexPath.row
                cell.favButton.tag = indexPath.row
                cell.favButton.addTarget(self, action: #selector(HomeCategoriesCell.favButtonA(_:)), for: .touchUpInside)
                cell.addToCart.tag = indexPath.row
                cell.addToCart.addTarget(self, action: #selector(HomeCategoriesCell.cartButtonA(_:)), for: .touchUpInside)
                cell.share.tag = indexPath.row
                cell.share.addTarget(self, action: #selector(HomeCategoriesCell.shareButtonA(_:)), for: .touchUpInside)
                if favFuncsClass.saveFavData(data: productCategory?.products?[indexPath.row], state: nil){
                    cell.isFav = true
                    print("that is the index :  \(indexPath.row) in row  : \(catIndexPath)")
                }else { cell.isFav = false }
                if onCartFuncsClass.saveCartData(data: productCategory?.products?[indexPath.row], state: nil){
                    cell.onCart = true
                }else { cell.onCart = false }
//        cell.configCell(products: nil)
        if cell.tag == indexPath.row {
            cell.configCell(products: productCategory?.products?[indexPath.item])
        }
        cell.catNum = indexPath.row
        if let prImage = productCategory?.products?[indexPath.item].image_pr {
            cell.productImage.image = prImage
        }else {
            downloadImage(data: (productCategory?.products![indexPath.row])!, completionHandler: { (img) in
                
                cell.productImage.image = img

        }) }
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 234)
        
    }

    func downloadImage(data : productDetails,completionHandler handler: @escaping (_ image : UIImage) -> Void) {
        if let imageString = data.image_url {

        DispatchQueue.global(qos: .userInitiated).async {
            () -> Void in
            let imageUrl = URL(string: imageString)
            guard let url = imageUrl , let imageData = try? Data(contentsOf: url) else { return }
            data.image_pr = UIImage(data: imageData )
            
            DispatchQueue.main.async(execute: {
                () -> Void in
                handler(data.image_pr!)
                self.productsCollectionView.reloadData()

            })
        }
    }
    }
    
//    func addImageToProduct(data:[productDetails]) {
//        DispatchQueue.global(qos: .userInteractive).async { () -> Void in
//            
//            for x in data {
////                guard let imageString = x.image_url else { return}
//                let imageUrl = URL(string: imageString!)
//                guard let url = imageUrl , let imageData = try? Data(contentsOf: url) else { return }
//                x.image_pr = UIImage(data: imageData )
//            }
//            
//            
//            
//            DispatchQueue.main.async(execute: { () -> Void in
//           self.productsCollectionView.reloadData()
//            })
//        }
//    }
    
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
//        if onCartFuncsClass.saveCartData(data: productCategory?.products?[indexPath.row], state: nil){
//            print("selected Product and teh state is √ \(catIndexPath)")
//            
//        }else {
//            print("selected Product and teh state is X \(catIndexPath)")
//            
//        }
                let data = productCategory?.products?[indexPath.row]
        
                categoriesHomePageVC?.showProductDetailsVC(productDetails: indexPath.row, CatIndex: catIndexPath!, product : data)
    }
    
    

}



