//
//  MyProfileVC.swift
//  HyperApp
//
//  Created by Killvak on 20/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit
class MyProfileVC: UIViewController , UITableViewDelegate , UITableViewDataSource  {
    @IBOutlet weak var sideMenuBOL: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    var profileHeaderMC : ProfileHeaderM?
    //var coredataCounterC : CoreDataProductFunctions?
    
    var titlesArray =  ["My Wish List","My Cart"]
    var imagesArray = ["Heart With Pulse","Shopping Cart"]
    

    
    override func viewWillAppear(_ animated: Bool) {
        self.revealViewController().panGestureRecognizer().isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.sectionHeaderHeight = 270
        self.tableView.rowHeight = 45
        self.tableView.delegate = self
        self.tableView.dataSource = self
    
        revealMenu()
        
        setHeaderCellUI()
        if UserDefaults.standard.value(forKey: "userEmail") != nil  {
            titlesArray = ["My Wish List","My Cart","My Orders","My AddressBook"]
            imagesArray = ["Heart With Pulse","Shopping Cart" , "MyOrders" , "MyAddress"]
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return titlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyProfileMainCell
        cell.configCell(name: titlesArray[indexPath.row], imageName: imagesArray[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let x = self.storyboard?.instantiateViewController(withIdentifier: "FavListVC") as! FavListVC
            x.isnotSubV = false 
            navigationController?.pushViewController(x, animated: true )
        case 1:
            print(1)
            let x = self.storyboard?.instantiateViewController(withIdentifier: "OnCartVC") as! OnCartVC
            x.isNotSubView = false
            navigationController?.pushViewController(x, animated: true )
        case 2:
            print("My Orders")
        case 3:
            print("My Address")
        default:
            print("error in  my Profile  switch")
        }
    }
    
  
    
    
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! MyProfileCellHeader
        headerCell.backgroundColor = UIColor.gray
        headerCell.configCell(model: profileHeaderMC!)
        return headerCell
    }
    
    
    func setHeaderCellUI() {
        //coredataCounterC = CoreDataProductFunctions()
        profileHeaderMC = ProfileHeaderM()
        profileHeaderMC?.itemsOnCart = "0"
        profileHeaderMC?.favCount = "0"
        profileHeaderMC?.boughtItemsCount = "\(0)"
        if let image = BackTableVC.profileImage {
            profileHeaderMC?.image =  image

        }else {
            profileHeaderMC?.image =   UIImage(named:"3-userWelcomeingImage")

        }
    }

    
}


