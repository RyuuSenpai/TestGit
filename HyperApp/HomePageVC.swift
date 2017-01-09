 //
 //  HomePageVC.swift
 //  HyperApp
 //
 //  Created by Killvak on 18/10/2016.
 //  Copyright © 2016 Killvak. All rights reserved.
 //
 
 import UIKit
 import RealmSwift
 class HomePageVC: UIViewController  ,  UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout  {
    
    
    @IBOutlet weak var sideMenuBOL: UIBarButtonItem!
    
    @IBOutlet weak var mainProductsRow: UICollectionView!
    
    @IBOutlet weak var cartBarButton: UIBarButtonItem!
    @IBOutlet weak var switchLanguageBtnOL: UIBarButtonItem!
    
    private let reuseIdentifier = "CategoriesCell"
    var dataISA :Bool = true
    
    //@AukHeaderID
    let imagelist = [UIImage(named:"0"),UIImage(named:"1"),UIImage(named:"2"),UIImage(named:"3"),UIImage(named:"4"),UIImage(named:"5")]
    
    //@end Auk
    
    var itemsInCart : Int = 0
    var catPageNum = 2
    var productCategory : [ProductCategories]?
    var productCatData : ProductCategories?
    
    
    override func viewWillAppear(_ animated: Bool) {
        //        self.revealViewController().panGestureRecognizer().isEnabled = true
        
        self.view.squareLoading.backgroundColor = UIColor.white
        self.view.squareLoading.color = UIColor.red
        if dataISA {
            self.cartBarButton.isEnabled = false
            self.sideMenuBOL.isEnabled = false
            self.switchLanguageBtnOL.isEnabled = false
        }else {
            self.cartBarButton.isEnabled = true
            self.sideMenuBOL.isEnabled = true
            self.switchLanguageBtnOL.isEnabled = true
        }
        
        
        
        upDateItemInCart()
        cartNumberOfItemsBadge()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        
        //        setUpButtonRoundedCorners(button: dailyOfferBtn)
        recivedNotification()
        //        productCategory = ProductCategories.productCategories()
        mainProductsRow.register(LargeHomeCategoriesCell.nib, forCellWithReuseIdentifier: LargeHomeCategoriesCell.identifier)
        mainProductsRow.delegate = self
        mainProductsRow.dataSource = self
        
        infiniteScroll()
        
        self.sendNotification()
    }
    
    func infiniteScroll() {
        //Stop Animation
//        mainProductsRow.setShouldShowInfiniteScrollHandler { (_) -> Bool in
//            
//            return true
//        }
        mainProductsRow.addInfiniteScroll { (collectionView) -> Void in
            self.mainProductsRow.performBatchUpdates({ () -> Void in
                self.catPageNum += 1
                self.updateData()
                // update collection view
            }, completion: { (finished) -> Void in
                // finish infinite scroll animations
                self.mainProductsRow.finishInfiniteScroll()
            });
        }
    }
    
    func sendNotification() {
        
        NotificationCenter.default.post(name: REFRESH_HOMEPAGE_CELLS, object: nil)
    }
    
    func updateData() {
        if  self.productCategory == nil {
        self.view.squareLoading.start(0.0)
        }
        productCatData = ProductCategories()
        productCatData?.downloadHomePageData(pageNum: catPageNum, compeleted: { (productCategory) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                self.switchLanguageBtnOL.isEnabled = true
                self.dataISA = false
                if let productData = self.productCategory{
                    let productData = productData + productCategory
                    self.productCategory = productData
                }else {
                self.productCategory = productCategory
                }
                print("Done with getting Data")
                self.view.squareLoading.stop(0.0)
                self.mainProductsRow.reloadData()
                self.revealMenu()
            }
            
        })
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
        cell.seeMore.tag = (indexPath.row - 1 )
        cell.seeMore.addTarget(self, action: #selector(self.seeMore(_:)), for: UIControlEvents.touchUpInside)
        cell.tag = indexPath.row - 1
        cell.productCategory = nil
        if cell.tag == indexPath.row - 1{
            cell.productCategory = productCategory?[indexPath.row - 1 ]
            
        }
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
        
//        subCategoryVC.catID =
        
        navigationController?.pushViewController(subCategoryVC, animated: true)
    }
    
    
    
    
    func showProductDetailsVC(productDetails : Int , CatIndex : Int , product : ProductDetails?) {
        
        let productDetailController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
        productDetailController.product_id = product?.id
        productDetailController.products = product
        navigationController?.pushViewController(productDetailController, animated: true)
    }
    // MARK: UICOllectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    
    // MARK: UICOllectionViewLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            return CGSize(width: self.mainProductsRow.frame.width, height:(view.frame.size.width * 0.47) * 1.3 + 32)
            
        }
        return ad.mainRowCellSize!
    }
    
    @IBAction func CartBtnA(_ sender: AnyObject) {
        let onCartVC = self.storyboard?.instantiateViewController(withIdentifier: "OnCartVC") as! OnCartVC
        
        onCartVC.isNotSubView = false
        navigationController?.pushViewController(onCartVC, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        
        if kind == UICollectionElementKindSectionHeader {
            let headerView: HomeAukCollectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AukHeaderID", for: indexPath) as! HomeAukCollectionViewHeader
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(HomePageVC.handleTap))
            headerView.promotionScrollView.addGestureRecognizer(tap)
            headerView.Btn1OL.addTarget(self, action: #selector(self.hotDealsButton(_:)), for: UIControlEvents.touchUpInside)
            headerView.Btn2OL.addTarget(self, action: #selector(self.hotDealsButton(_:)), for: UIControlEvents.touchUpInside)
            headerView.Btn3OL.addTarget(self, action: #selector(self.hotDealsButton(_:)), for: UIControlEvents.touchUpInside)
            
            return headerView
            
        }else {
            
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TheFooter", for: indexPath) as! HomeFooter
            
            return footerView
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.mainProductsRow.frame.width, height:(view.frame.size.height * 0.40))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.mainProductsRow.frame.width, height:(view.frame.size.height * 0.09))
    }
    
    
    func hotDealsButton(_ sender : UIButton) {
        
        let seeMoreA = self.storyboard?.instantiateViewController(withIdentifier: "SeeMoreVC") as! SeeMoreVC
        seeMoreA.productCatSelected = productCategory?[sender.tag]
        navigationController?.pushViewController(seeMoreA, animated: true)
        
        switch sender.tag {
        case 1:
            print("that is the 1 Button")
        case 2:
            print("that is the 2 Button")
        case 3:
            print("that is the 3 Button")
        default:
            print("Error with the HotDeals Buttons Switch Case")
            
        }
    }
    
    func handleTap() {
        
        print("that is the indexPath : \(HomeAukCollectionViewHeader.theIndex)")
        let mySettings: PromotionVC = self.storyboard?.instantiateViewController(withIdentifier:"PromotionVC") as! PromotionVC
//        let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.flipHorizontal    /*.partialCurl */
//        mySettings.modalTransitionStyle = modalStyle
        if let currentImageIndex = HomeAukCollectionViewHeader.theIndex {
            mySettings.promotionImageFlag = imagelist[currentImageIndex]
            
        }
        navigationController?.pushViewController(mySettings, animated : true )
//        self.present(mySettings, animated: true, completion: nil)
    }
    
    
    
    
    func shareItems(sender : UIButton , data:ProductDetails?) {
        
        guard let datA = data , let name = datA.name , let price = datA.price else { return }
        let img: UIImage = #imageLiteral(resourceName: "PlaceHolder")
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
    
    @IBAction func switchLanguage(_ sender: UIBarButtonItem) {
        var transition: UIViewAnimationOptions = .transitionFlipFromLeft
        if L102Language.currentAppleLanguage() == "en" {
            L102Language.setAppleLAnguageTo(lang: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            L102Language.setAppleLAnguageTo(lang: "en")
            transition = .transitionFlipFromRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        rootviewcontroller.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "rootnav")
        let mainwindow = (UIApplication.shared.delegate?.window!)!
        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
        UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
        }) { (finished) -> Void in
            
        }
    }
    
    
    
 }
 
