//
//  OrderDetailsVC.swift
//  HyperApp
//
//  Created by Killvak on 04/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit
import AlamofireImage

class OrderDetailsVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var orderNum: UILabel!
    @IBOutlet weak var numOfItem: UILabel!
    @IBOutlet weak var dateOfOrder: UILabel!
    
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var storeUnderLine: UIView!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carUnderLine: UIView!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var hmeUnderLine: UIView!
    @IBOutlet weak var num2Image: UIImageView!
    @IBOutlet weak var num1Image: UIImageView!
    @IBOutlet weak var num3Image: UIImageView!
    @IBOutlet weak var confirmedImage: UIImageView!
    
    var dataList : OrderList?
    
    var orderNumber : String?
    var numOfItems : String?
    var dateofOrders : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        roundedCournersTableView()
        self.orderNum.text = orderNumber ?? ""
        self.numOfItem.text = numOfItems ?? ""
        self.dateOfOrder.text = dateofOrders ?? ""
        // Do any additional setup after loading the view.
        checkOrderState()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = dataList?.orderCartList?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OrderDetailsViewCell
        guard let data = dataList?.orderCartList?[indexPath.row] else { return cell }
        cell.title.text = data.product_name
        cell.quantity.text = "\(data.quantity)"
        cell.price.text = ""
        if let url = URL(string: data.product_image ) {
            cell.productImage.af_setImage(
                withURL: url,
                placeholderImage: UIImage(named: "PlaceHolder"),
                filter: nil,
                imageTransition: .crossDissolve(0.2)
            )
        }
        return cell
    }
    
    
    func roundedCournersTableView() {
        
        //for table view border
        tableView.layer.borderColor = UIColor .clear.cgColor
        tableView.layer.borderWidth = 1.0
        
        //for shadow
        //        let containerView:UIView = UIView(frame:self.tableView.frame)
        //        containerView.backgroundColor = UIColor.white
        //        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        //        containerView.layer.shadowOffset =   CGSize(width : -10,height: 10); //Left-Bottom shadow
        //containerView.layer.shadowOffset = CGSizeMake(10, 10); //Right-Bottom shadow
        //        containerView.layer.cornerRadius = 10
        //        containerView.layer.shadowOpacity = 1.0
        //        containerView.layer.shadowRadius = 2
        //
        //        containerView.layer.masksToBounds = true
        //        //for rounded corners
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
        //        self.view.addSubview(containerView)
        //        containerView.addSubview(tableView)
    }
    
    
    func checkOrderState() {
        guard let state = dataList?.currentState?.name else { return }
        
        if  state.contains("Pending") {
            pending(false)
        }else if  state.contains("Confirmed") {
            confirmed(true)
        }else if  state.contains("Shipping") {
            shipping(true)
        }else if  state.contains("Delivered") {
            delivered(true)
        }else {
            pending(false)
        }
        
    }
    
    func pending(_ state : Bool) {
        
        if state {
            confirmedImage.image = UIImage(named:"verified")
        }else {
            confirmedImage.image = UIImage(named:"notVerfied") 
         }
    }
    
    func confirmed(_ state : Bool) {
        
        if state {
            pending(true)
            storeImage.image = #imageLiteral(resourceName: "Garage Closed_100")
            num1Image.image = #imageLiteral(resourceName: "Circled 1_fa0011_32-1")
            storeUnderLine.backgroundColor = .red
        }else {
            storeImage.image = #imageLiteral(resourceName: "OffGarage Closed_100")
            num1Image.image = #imageLiteral(resourceName: "Circled 1_878787_32")
             storeUnderLine.backgroundColor = .lightGray
            self.shipping(false)
        }
    }
    
    func shipping(_ state : Bool) {
        
        if state {
            confirmed(true)
            carImage.image = #imageLiteral(resourceName: "Shipped_100")
            num2Image.image = #imageLiteral(resourceName: "Circled 2 _fa0011_32")
             carUnderLine.backgroundColor = .red
        }else {
            carImage.image = #imageLiteral(resourceName: "Shipped_999999_75")
            num2Image.image = #imageLiteral(resourceName: "Circled 2 _878787_32")
             carUnderLine.backgroundColor = .lightGray
            self.delivered(false)
        }
    }
    
    func delivered(_ state : Bool) {
        
        if state {
            shipping(true)
            homeImage.image = #imageLiteral(resourceName: "Cottage_100")
            num3Image.image = #imageLiteral(resourceName: "Circled 3 _fa0011_32-1")
             hmeUnderLine.backgroundColor = .red
        }else {
            homeImage.image = #imageLiteral(resourceName: "Cottage_999999_75")
            num3Image.image = #imageLiteral(resourceName: "Circled 3 _878787_32")
             hmeUnderLine.backgroundColor = .lightGray
            
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
    
}
