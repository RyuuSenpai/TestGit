//
//  OnCartVC.swift
//  HyperApp
//
//  Created by Killvak on 06/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit
import CoreData
class OnCartVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

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
        if self.revealViewController() != nil {
            let sideMenuBtn = UIBarButtonItem(image: UIImage(named: "browsebutton"), style: .plain, target: self.revealViewController(), action: #selector(getter: UIDynamicBehavior.action)) // action:#selector(Class.MethodName) for swift 3
            
            self.navigationItem.leftBarButtonItem  = sideMenuBtn
            sideMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            //                 self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            //            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        }
        isNotSubView = true
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
        
     
        return cell
    }
 
    
    func addToQuantity(sender:UIButton)  {
        
        let onCart = items?[sender.tag]
        guard let itemQuantity = onCart?.quantity , itemQuantity >= Int16(0)  ,let itemPrice = onCart?.price, itemQuantity <= Int16(12) else {  return }
        let count = Int(itemQuantity) + 1
        onCart?.quantity = Int16(count)
//        let price = Double(itemQuantity) * Double(itemPrice)
//        onCart?.qXprice = price
        
        ad.saveContext()
        getTheData()
    }
    func subtractFromQuantity(sender:UIButton)  {
        let onCart = items?[sender.tag]
        guard let itemQuantity = onCart?.quantity ,  let quantXprice = onCart?.qXprice ,  itemQuantity >= Int16(2) else {  return }

        let count = Int(itemQuantity) - 1
        onCart?.quantity = Int16(count)
//        let price =   Double(quantXprice) / Double(itemQuantity)
//        onCart?.qXprice = price

        ad.saveContext()
        getTheData()
    }
    
    
    func getTheData() {
        do {
            items = try context.fetch(CDOnCart.fetchRequest())
          
            if let items = items  {
                totalPrice = 0

                for i in 0..<items.count {

                    let price =  items[i].price
                    let quantity = items[i].quantity
//                totalPrice = totalPrice +  price
                    items[i].qXprice = price * Double(quantity)
                    let y = items[i].qXprice
                    totalPrice += y
  
                    
                }
                
                if items.count == 0 {
                    totalPrice = 0
                }
                
            }
            self.totalPriceValue.text = "\(totalPrice) L.E"
            
        }catch let error as NSError {
            print("that is the error in Oncart DataBase : \(error.localizedDescription)")
            self.totalPriceValue.text = " "
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let items = items else {
                return
            }
            let item = items[indexPath.row]
            context.delete(item)
            ad.saveContext()
            getTheData()
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 250.0;//Choose your custom row height
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

}
