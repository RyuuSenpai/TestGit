//
//  OnCartVC.swift
//  HyperApp
//
//  Created by Killvak on 06/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit
import RealmSwift
class OnCartVC: UIViewController   {
    
    @IBOutlet weak var emptyCartPH: UIImageView!
    @IBOutlet weak var totalPriceValue: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editNavBtn: UIBarButtonItem!
    @IBOutlet weak var deleteNavBtn: UIBarButtonItem!
    
    var filledHeartSet = Set<NSIndexPath>()
    
    var postRequest : PostReviewRequest!
    var items : [CDOnCart]?
    var deletedItemsindex = [Int]()
    var isNotSubView = true
    var totalPrice : Double = 0
    var editSelected = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getTheData()
        if isNotSubView {
            self.revealMenu()
        }
        isNotSubView = true
        
//        if let item =  items , item.count  < 2 {
            self.editNavBtn.title = ""
            self.editNavBtn.isEnabled = false
//        }
        

     
//        SweetAlert().showAlert("Are you sure?", subTitle: "You file will permanently delete!", style: AlertStyle.warning, buttonTitle:"Cancel", buttonColor: green , otherButtonTitle:  "Yes, delete it!", otherButtonColor: red ) { (isOtherButton) -> Void in
//            if isOtherButton == true {
//                
//                print("Cancel Button  Pressed")
//            }
//            else {
//         
//                SweetAlert().showAlert("Deleted!", subTitle: "Your imaginary file has been deleted!", style: AlertStyle.success)
//                
//                
//            }
//        }
// 

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.revealViewController().panGestureRecognizer().isEnabled = false
        self.navigationItem.title = setOutLetsTitle(arabicTitle: "المشتريات", engTitle: "On Cart")
        //        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.deleteNavBtn.image = nil
        
        navigationController?.setColor()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        sendNotification()
    }
    
    
    func sendNotification() {
        
        NotificationCenter.default.post(name: REFRESH_HOMEPAGE_CELLS, object: nil)
        NotificationCenter.default.post(name: REFRESH_PRODUCT_DETAILS_ICONS, object: nil)
        
    }
    
    func postOnCartItemData() -> [Dictionary<String , Int>] {
        
        guard  let items = items else {
            return [[:]]
        }
        var pars = [Dictionary<String , Int>]()
        for i in items {
            var par  = [String:Int]()
            
            par = ["item_id" : i.id , "item_quantity":i.quantity]
            pars.append(par)
        }
       return pars
    }
    
    func downloadImage(index : Int , completionHandler handler: @escaping (_ imageData : Data) -> Void) {
        guard let items = self.items , let url = URL(string: items[index].imgString) else { return }
        
        DispatchQueue.global(qos: .userInitiated).async {
            () -> Void in
            
            let imgData = try? Data(contentsOf: url)
            DispatchQueue.main.async(execute: {
                () -> Void in
                if let img = imgData {
                    handler(img)
                    
                }
            })
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func checkOutBtnAct(_ sender: AnyObject) {
        if ad.isUserLoggedIn() {
            print("checkOutBtnAct")
            /*
            self.postRequest = PostReviewRequest()
            let parameter2 =  postOnCartItemData()
            guard let id = UserDefaults.standard.value(forKey: "User_ID") as? String else { print("nill in User_ID"); return }
            self.postRequest.postReqMakeOrder(userID: id, items: parameter2, completed: {
               print("DONE : checkOutBtnAct ")
//      SweetAlert().showAlert("Deleted!", subTitle: "Your imaginary file has been deleted!", style: AlertStyle.success)
//                ad.reloadApp()
            })
           */

            self.performSegue(withIdentifier: "LocationsSegue", sender: self)
        }else {
            performSegue(withIdentifier: "login", sender: self )
        }
        

    }
    
    func getTheData() {
        do {
            let realm = try Realm()
            let cartL = realm.objects(CDOnCart.self)
            items = [CDOnCart]()
            for y in cartL {
                items?.append(y)
            }
            
            if let items = items {
                totalPrice = 0
                
                for i in 0..<items.count {
                    
                    let price =  items[i].price
                    let quantity = items[i].quantity
                    //                totalPrice = totalPrice +  price
                    let y  = price * Double(quantity)
                    totalPrice += y
                    
                    
                }
                
                if items.count == 0 {
                    totalPrice = 0
                }
                
            }
            self.totalPriceValue.text = "\(totalPrice) L.E"
            
            if let item =  self.items , item.count < 1 {
                self.emptyCartPH.isHidden = false
            }else {
                self.emptyCartPH.isHidden = true
            }
            
            
            tableView.reloadData()
            
        }catch let err as NSError {
            print("that is error ya man   :   \(err)")
        }
        
    }
    
    
    
    @IBAction func editTableViewData(_ sender: UIBarButtonItem) {
        if (self.editNavBtn.title == "Edit") {
            self.editNavBtn.title = "Done"
            self.deleteNavBtn.image = #imageLiteral(resourceName: "1-remove")
        } else {
            self.editNavBtn.title = "Edit"
            self.deleteNavBtn.image = nil
        }
        self.tableView.reloadData()
    }
    
    
    
    
}
