//
//  HomePageVC.swift
//  HyperApp
//
//  Created by Killvak on 18/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit
import RealmSwift
class HomePageVC: UIViewController  ,  UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var sideMenuBOL: UIBarButtonItem!
    
    @IBOutlet weak var mainProductsRow: UICollectionView!
    @IBOutlet weak var cartBarButton: UIBarButtonItem!
    
    static var profileImage : UIImage?
    private let reuseIdentifier = "CategoriesCell"
    var dataISA :Bool?
    
    //@AukHeaderID
    let imagelist = [UIImage(named:"0"),UIImage(named:"1"),UIImage(named:"2"),UIImage(named:"3"),UIImage(named:"4"),UIImage(named:"5")]

    //@end Auk
    
    var itemsInCart : Int = 0
 
    var productCategory : [ProductCategories]?
    var productCatData : ProductCategories?
    

    override func viewWillAppear(_ animated: Bool) {
        self.view.squareLoading.backgroundColor = UIColor.white
        self.view.squareLoading.color = UIColor.red
        if dataISA != nil {
            sideMenuBOL.isEnabled  = true
            cartBarButton.isEnabled = true
        }else {
        sideMenuBOL.isEnabled  = false
        cartBarButton.isEnabled = false
        }
        upDateItemInCart()
        cartNumberOfItemsBadge()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
       

        HomePageVC.profileImage = profileMenuImage()
        recivedNotification()
//        productCategory = ProductCategories.productCategories()
        /*
        self.cartBarButton.badgeBGColor = UIColor.red
        self.cartBarButton.badgeTextColor = UIColor.white
        self.cartBarButton.badgeValue = "\(itemsInCart)"
        self.cartBarButton.shouldAnimateBadge = true
        self.cartBarButton.shouldHideBadgeAtZero = true
        
        if  itemsInCart >= 1 {
            self.cartBarButton.tintColor = UIColor.black
        }else {
            self.cartBarButton.tintColor = UIColor.white
        }*/
        mainProductsRow.register(LargeHomeCategoriesCell.nib, forCellWithReuseIdentifier: LargeHomeCategoriesCell.identifier)
        mainProductsRow.delegate = self
        mainProductsRow.dataSource = self
        
    }
    
    func updateData() {
        self.view.squareLoading.start(0.0)
        productCatData = ProductCategories()
        productCatData?.downloadHomePageData { (productCategory) in
            self.dataISA = true
            self.productCategory = productCategory
            print("Done with getting Data")
            self.view.squareLoading.stop(0.0)
            self.mainProductsRow.reloadData()
            self.revealMenu()
        }
    }
    
    func recivedNotification() {
        NotificationCenter.default.addObserver(forName: UPDATE_CART_BADGE, object: nil , queue: nil) { notification  in
            //            let largerCell = HomeCategoriesCell()
            //            largerCell.reloadData()
            self.upDateItemInCart()
            self.cartNumberOfItemsBadge()
            print("recivedNotification : \(notification)")
        }
    }
    
    
    func revealMenu() {
        sideMenuBOL.isEnabled  = true
        cartBarButton.isEnabled = true
        if self.revealViewController() != nil {
            sideMenuBOL.target = self.revealViewController()
            sideMenuBOL.action = #selector(SWRevealViewController.revealToggle(_:))
            self.revealViewController().rearViewRevealWidth = self.view.frame.width * 0.75
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    
    
    func cartNumberOfItemsBadge(){
     
            self.cartBarButton.badgeValue = "\(itemsInCart)"

        self.cartBarButton.badgeBGColor = UIColor.red
        self.cartBarButton.badgeTextColor = UIColor.white
        self.cartBarButton.shouldAnimateBadge = true
        self.cartBarButton.shouldHideBadgeAtZero = true
        if  itemsInCart >= 1 {
            self.cartBarButton.tintColor = UIColor.black
            
        }else {
            self.cartBarButton.tintColor = UIColor.white
        }
    }
    
    

    
    @IBAction func searchGesture(_ sender: AnyObject) {
        print("Search clicked")
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICOllectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
       
                if let count = productCategory?.count {
                return count + 1
            }
            return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let   cell  = collectionView.dequeueReusableCell(withReuseIdentifier: LargeHomeCategoriesCell.identifier, for: indexPath) as! LargeHomeCategoriesCell
            cell.categoriesHomePageVC = self
            cell.catIndexPath = indexPath.row
            cell.productCategories = productCategory
            cell.seeMore.addTarget(self, action: #selector(self.seeMoreCat(_:)), for: UIControlEvents.touchUpInside)
            return cell
        }
            let   cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "RowCell", for: indexPath) as! HomeCategoriesCell
            
            cell.categoriesHomePageVC = self
            cell.catIndexPath = indexPath.row
            cell.productCategory = productCategory?[indexPath.row - 1 ]
        cell.seeMore.tag = (indexPath.row - 1 )
        cell.seeMore.addTarget(self, action: #selector(self.seeMore(_:)), for: UIControlEvents.touchUpInside)
            
            return cell
            
        
    }
    func seeMore(_ sender:UIButton) {
      print(sender.tag)
        let seeMoreA = self.storyboard?.instantiateViewController(withIdentifier: "SeeMoreVC") as! SeeMoreVC
        seeMoreA.productCatSelected = productCategory?[sender.tag]
        navigationController?.pushViewController(seeMoreA, animated: true)
        
    }
    func seeMoreCat(_ sender:UIButton) {
        print(sender.tag)
        let seeMoreA = self.storyboard?.instantiateViewController(withIdentifier: "SeeMoreCategories") as! SeeMoreCategories
//        seeMoreA.productCatSelected = productCategory?[sender.tag]
        seeMoreA.productCategories = productCategory
        navigationController?.pushViewController(seeMoreA, animated: true)
        
    }
    
    func showSubCategory(productDetails : Int , CatIndex : Int) {
        let subCategoryVC = self.storyboard?.instantiateViewController(withIdentifier: "SubCategoryVC") as! SubCategoryVC
        
        
        navigationController?.pushViewController(subCategoryVC, animated: true)
    }
    
    
    
    
    func showProductDetailsVC(productDetails : Int , CatIndex : Int , product : productDetails?) {
        let productDetailController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
        
        productDetailController.products = product
        
        navigationController?.pushViewController(productDetailController, animated: true)
    }
    // MARK: UICOllectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    
        
    }
    
    // MARK: UICOllectionViewLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            return CGSize(width: self.mainProductsRow.frame.width, height:300)

        }
            return CGSize(width: self.mainProductsRow.frame.width, height:264)
            //            return CGSize(width: self.mainProductsRow.frame.width, height: view.frame.height * 0.25)
        
    }
    @IBAction func CartBtnA(_ sender: AnyObject) {
        let onCartVC = self.storyboard?.instantiateViewController(withIdentifier: "OnCartVC") as! OnCartVC

        onCartVC.isNotSubView = false
        navigationController?.pushViewController(onCartVC, animated: true)
        
    }
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
    
    let headerView: HomeAukCollectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AukHeaderID", for: indexPath) as! HomeAukCollectionViewHeader
        
        
            let tap = UITapGestureRecognizer(target: self, action: #selector(HomePageVC.handleTap))
            headerView.promotionScrollView.addGestureRecognizer(tap)
            

        return headerView
        
    }
    func handleTap() {

        print("that is the indexPath : \(HomeAukCollectionViewHeader.theIndex)")
        let mySettings: PromotionVC = PromotionVC(nibName: "PromotionVC", bundle: nil)
        let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.flipHorizontal    /*.partialCurl */
        mySettings.modalTransitionStyle = modalStyle
        if let currentImageIndex = HomeAukCollectionViewHeader.theIndex {
            mySettings.promotionImageFlag = imagelist[currentImageIndex]
            
        }
        self.present(mySettings, animated: true, completion: nil)
    }
    
    


    func shareItems(sender : UIButton , data:productDetails?) {
        
        guard let datA = data , let name = datA.name , let price = datA.price else { return }
        let img: UIImage = UIImage(named: "1")!
        let shareItems:Array = [img, name , price ] as [Any]
        
       let  activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
//        activityViewController.excludedActivityTypes = [UIActivityType.print, UIActivityType.postToWeibo, UIActivityType.copyToPasteboard, UIActivityType.addToReadingList, UIActivityType.postToVimeo]
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone {
            self.present(activityViewController, animated: true, completion: nil)
        } else {
//
//            if activityViewController.respondsToSelector(Selector("popoverPresentationController")) {
//                activityViewController.popoverPresentationController?.sourceView = self.view
//        }

            
            
        
        
        }
    }
    
    func profileMenuImage() -> UIImage {
        if let imageString = UserDefaults.standard.value(forKey: "profileImage") , let imageURL = URL(string: imageString as! String){
            
            do {
                let image = try Data(contentsOf: imageURL )
                return  UIImage(data: image)!
            }catch let error as NSError {
                print("Error in Sidmenu setImage",error )
                return UIImage(named:"3-userWelcomeingImage")!
            }
            
        }else {
            return UIImage(named:"3-userWelcomeingImage")!
        }
    }

    
}

