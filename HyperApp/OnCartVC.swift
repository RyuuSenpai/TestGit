//
//  OnCartVC.swift
//  HyperApp
//
//  Created by Killvak on 06/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit
import RealmSwift
class OnCartVC: UIViewController , UITableViewDelegate , UITableViewDataSource  {

    @IBOutlet weak var totalPriceValue: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var items : [CDOnCart]?
    var isNotSubView = true
    var totalPrice : Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getTheData()
        if isNotSubView {
            self.revealMenu()
        }
        isNotSubView = true
    }
    
        
    override func viewWillDisappear(_ animated: Bool) {
        sendNotification()

    }
    func sendNotification() {
    
        NotificationCenter.default.post(name: REFRESH_HOMEPAGE_CELLS, object: nil)
        NotificationCenter.default.post(name: REFRESH_PRODUCT_DETAILS_ICONS, object: nil)

    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = items?.count else {
            return 0
        }
        return count
           }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OnCartCell
       
            cell.onCart = items?[indexPath.row]
        cell.removeFromQuantity.tag = indexPath.item
        cell.addToQuantity.tag = indexPath.item

        cell.removeFromQuantity.addTarget(self, action: #selector(subtractFromQuantity(sender:)) , for: UIControlEvents.touchUpInside)
        cell.addToQuantity.addTarget(self, action: #selector(addToQuantity(sender:)) , for: UIControlEvents.touchUpInside)
        if let item = items?[indexPath.row] {
//            getImage(data: item, completed: { (img) in
//                
//            cell.configCell(img: img)
//            })
            let imageUrl = URL(string: item.imgString)
            cell.tag = indexPath.row
            var img : UIImage?
    
            DispatchQueue.global(qos: .userInteractive).async { () -> Void in
                if cell.tag == indexPath.row
                {
                guard let url = imageUrl , let imageData = try? Data(contentsOf: url) else { return }
                img = UIImage(data: imageData )
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    if cell.tag == indexPath.row
                    {
                        cell.configCell(img: img)
                    }
                })
            }//Dispatch

        }
     
        return cell
    }
 
    
    func addToQuantity(sender:UIButton)  {
        
        do {
            let realm = try Realm()
            let onCart = items?[sender.tag]
            print("that is the quantity :  \(onCart?.quantity)")
            guard let itemQuantity = onCart?.quantity , itemQuantity > Int16(0)  ,let itemPrice = onCart?.price, itemQuantity <= Int16(12) else { print("addToQuantity error in guard Statement"); return }
            let count = Int(itemQuantity) + 1
            let price = Double(count) * Double(itemPrice)

            try realm.write{
                onCart?.quantity = Int16(count)
                onCart?.qXprice = price

                //                realm.add(onCart)
//                print("that Saved ya Man \(onCart.name)")
            }
            self.getTheData()
        }catch let err as NSError {
            print("that is error ya man   :   \(err)")
        }
        
        /*
        let onCart = items?[sender.tag]
        guard let itemQuantity = onCart?.quantity , itemQuantity >= Int16(0)  ,let itemPrice = onCart?.price, itemQuantity <= Int16(12) else {  return }
        let count = Int(itemQuantity) + 1
        onCart?.quantity = Int16(count)
//        let price = Double(itemQuantity) * Double(itemPrice)
//        onCart?.qXprice = price
        
        ad.saveContext()
        getTheData()*/
    }
    
  
    
    func subtractFromQuantity(sender:UIButton)  {
        
        do {
            let realm = try Realm()
            let onCart = items?[sender.tag]
            guard let itemQuantity = onCart?.quantity ,  let quantXprice = onCart?.qXprice ,let itemPrice = onCart?.price ,  itemQuantity >= Int16(2) else { print("subtractFromQuantity error in guard Statement"); return }
            let count = Int(itemQuantity) - 1
            print("that is the quantitiy \( Double(itemQuantity)) and that is the qprice : \( Double(quantXprice))")
            let price =   Double(quantXprice) - Double(itemPrice)
            print("the actual Price : \(price)")
            
            try realm.write{
                onCart?.quantity = Int16(count)
                onCart?.qXprice = price
                
                //                realm.add(onCart)
                //                print("that Saved ya Man \(onCart.name)")
            }
            self.getTheData()
        }catch let err as NSError {
            print("that is error ya man   :   \(err)")
        }
        
        
        /*
         let onCart = items?[sender.tag]
         guard let itemQuantity = onCart?.quantity ,  let quantXprice = onCart?.qXprice ,  itemQuantity >= Int16(2) else {  return }
         
         let count = Int(itemQuantity) - 1
         onCart?.quantity = Int16(count)
         let price =   Double(quantXprice) / Double(itemQuantity)
         onCart?.qXprice = price
         
         ad.saveContext()
         getTheData()*/
        
    }
    
    

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let items = items else {
                return
            }
            let item = items[indexPath.row]
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.delete(item)
                try realm.commitWrite()
                getTheData()

            }catch let err as NSError {
                print("error while deleting Row OnCart rror  : \(err)")
            }
            
            
        }
    }
    
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 240.0;//Choose your custom row height
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

            /*
             {
             items = try context.fetch(CDOnCart.fetchRequest())
             
             if let items = items  {
             totalPrice = 0
             
             for i in 0..<items.count {
             
             let price =  items[i].price
             let quantity = items[i].quantity
             //                totalPrice = totalPrice +  price
             items[i].qXprice = price * Double(quantity)
             var y = items[i].qXprice
             totalPrice += y
             
             
             }
             
             if items.count == 0 {
             totalPrice = 0
             }
             
             }
             self.totalPriceValue.text = "\(totalPrice) L.E"
             
             }
 
 */
            tableView.reloadData()

        }catch let err as NSError {
            print("that is error ya man   :   \(err)")
        }
    
    }
}
