//
//  ExtBtnActOnCartVC.swift
//  HyperApp
//
//  Created by Killvak on 16/01/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import Foundation
import RealmSwift
extension OnCartVC {
    
    
    func buttonClicked(_ sender:UIButton)
    {
        let ip = NSIndexPath(row: sender.tag, section: 0)
        
        // only store filled heart indexPath
        if filledHeartSet.contains(ip) {
            filledHeartSet.remove(ip)
            self.deletedItemsindex.remove(object: sender.tag)

        } else {
            filledHeartSet.insert(ip)
            self.deletedItemsindex.append(sender.tag)

        }
        print("that will be deleted list : \(self.deletedItemsindex)")
        let cell = tableView.cellForRow(at: ip as IndexPath) as! OnCartCell
        cell.deleteRowDataBtn.isSelected = !cell.deleteRowDataBtn.isSelected
    }
    
    
    
    
    @IBAction func deleteAllSelectedDataBtnAct(_ sender: UIBarButtonItem) {
        print("that will be deleted list : \(self.deletedItemsindex)")

        
            //            guard  let deleteItemsArray = self.deletedItems  else {
            //                self.editNavBtn.title = "Edit"
            //                self.deleteNavBtn.image = nil
            //                return
            //            }
        if (self.editNavBtn.title == "Done") && self.deletedItemsindex.count > 0  {
            
            
            
            for i in self.deletedItemsindex{
                let item = self.items?[i]
                print("that is the item in for loop in delete all seleted :  \(item)")
                do {
                    let realm = try Realm()
                    realm.beginWrite()
                    realm.delete(item!)
                    try realm.commitWrite()
                    print("that item Deleted : \(item)")
                }catch let err as NSError {
                    print("error while deleting Row OnCart rror  : \(err)")
                }
                

            SweetAlert().showAlert("Are you sure?", subTitle: "You file will permanently delete!", style: AlertStyle.warning, buttonTitle:"Cancel", buttonColor: green , otherButtonTitle:  "Yes, delete it!", otherButtonColor: red ) { (isOtherButton) -> Void in
                if isOtherButton == true {
                    
                    print("Cancel Button  Pressed")
                }
                else {
                    
                    
                        self.deletedItemsindex = []
                        self.getTheData()
                    }
                    self.filledHeartSet = Set<NSIndexPath>()
                    if let item =  self.items , item.count  < 2 {
                        self.editNavBtn.title = ""
                        self.editNavBtn.isEnabled = false
                        self.deleteNavBtn.image = nil
                        self.deleteNavBtn.isEnabled = false
                        
                    }
                    self.deletedItemsindex = []
                    SweetAlert().showAlert("Deleted!", subTitle: "Your imaginary file has been deleted!", style: AlertStyle.success)

                    self.tableView.reloadData()

                }
            }
        } else {
            self.editNavBtn.title = "Edit"
            self.deleteNavBtn.image = nil
            print("DO nothing and delete nothing : '\(self.deletedItemsindex)'")
            self.getTheData()
        }
              }

    
    
    
    func addToQuantity(sender:UIButton)  {
        
        do {
            let realm = try Realm()
            let onCart = items?[sender.tag]
            print("that is the quantity :  \(onCart?.quantity)")
            guard let itemQuantity = onCart?.quantity , itemQuantity > 0  ,let itemPrice = onCart?.price, itemQuantity <= 12 else { print("addToQuantity error in guard Statement"); return }
            let count = Int(itemQuantity) + 1
            let price = Double(count) * Double(itemPrice)
            
            try realm.write{
                onCart?.quantity = count
                onCart?.qXprice = price
                
                
            }
            self.getTheData()
        }catch let err as NSError {
            print("that is error ya man   :   \(err)")
        }
        
        
    }

    func subtractFromQuantity(sender:UIButton)  {
        
        do {
            let realm = try Realm()
            let onCart = items?[sender.tag]
            guard let itemQuantity = onCart?.quantity ,  let quantXprice = onCart?.qXprice ,let itemPrice = onCart?.price ,  itemQuantity >= 2 else { print("subtractFromQuantity error in guard Statement"); return }
            let count = Int(itemQuantity) - 1
            print("that is the quantitiy \( Double(itemQuantity)) and that is the qprice : \( Double(quantXprice))")
            let price =   Double(quantXprice) - Double(itemPrice)
            print("the actual Price : \(price)")
            
            try realm.write{
                onCart?.quantity = count
                onCart?.qXprice = price
                
                //                realm.add(onCart)
                //                print("that Saved ya Man \(onCart.name)")
            }
            self.getTheData()
        }catch let err as NSError {
            print("that is error ya man   :   \(err)")
        }
        
        
    }
    
    
}
