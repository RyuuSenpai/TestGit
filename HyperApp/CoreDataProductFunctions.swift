//
//  CoreDataProductFunctions.swift
//  HyperApp
//
//  Created by Killvak on 21/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import CoreData


class CoreDataProductFunctions {
    

    func checkIfFav(data:productDetails?) ->Bool {
        let fetchRequest : NSFetchRequest<CDFavList> = CDFavList.fetchRequest()
        let  predicate = NSPredicate(format: "name == %@", (data?.name)!)
        fetchRequest.predicate = predicate
        do {
            
            
            let fetcjResult = try context.fetch(fetchRequest)
            if fetcjResult.count > 0 {
                print("Already Fav in favCheaker")
                return true
            }else {
                return false
            }
        } catch let error as NSError {
            print("That is the error in FavListCoreData : \(error.localizedDescription)")
            return false
        }

    }
    func checkIfOncart(data:productDetails?) ->Bool {

        let fetchRequest : NSFetchRequest<CDOnCart> = CDOnCart.fetchRequest()
        let  predicate = NSPredicate(format: "name == %@", (data?.name)!)
        fetchRequest.predicate = predicate
        do {
            
            
            let fetcjResult = try context.fetch(fetchRequest)
            if fetcjResult.count > 0 {
                print("Already onCart")
                return true
            }else  {
              return false
            }
        } catch let error as NSError {
            print("That is the error in FavListCoreData : \(error.localizedDescription)")
            return false 
        }
        

        
    }
    func favCoreData(data:productDetails?, favBool:Bool) {
        let fetchRequest : NSFetchRequest<CDFavList> = CDFavList.fetchRequest()
        print("that is hte shit id : \((data?.id)!)"   )
        let  predicate = NSPredicate(format: "name == %@", (data?.name)!)
        fetchRequest.predicate = predicate
        do {
            
            
            let fetcjResult = try context.fetch(fetchRequest)
            if fetcjResult.count > 0 {
                print("Already Fav")
                if !favBool{
                    print("will delete : \((data?.name)!)")
                    context.delete(fetcjResult[0])
                    ad.saveContext()
                }
            }else if favBool {
                
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
    
    
     func cartCoreData(data:productDetails?, onCart:Bool) {
        
        let fetchRequest : NSFetchRequest<CDOnCart> = CDOnCart.fetchRequest()
        let  predicate = NSPredicate(format: "name == %@", (data?.name)!)
        fetchRequest.predicate = predicate
        do {
            
            
            let fetcjResult = try context.fetch(fetchRequest)
            if fetcjResult.count > 0 {
                print("Already onCart")
                if !onCart{
                    print("will delete : \((data?.name)!)")
                    context.delete(fetcjResult[0])
                    ad.saveContext()
                }
            }else if onCart {
                
                let CartItem = CDOnCart(context: context)
                context.mergePolicy = CartItem
                CartItem.name  = data?.name
                CartItem.quantity = 1
                if let price = data?.price {
                    CartItem.price = price
                }else { print("error in price in HomeCat save onCart")}
                ad.saveContext()
                print("saved data")
            }
        } catch let error as NSError {
            print("That is the error in FavListCoreData : \(error.localizedDescription)")
        }
        

        
    }
    
}
