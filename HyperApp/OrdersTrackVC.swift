//
//  OrdersTrackVC.swift
//  HyperApp
//
//  Created by Killvak on 04/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit

class OrdersTrackVC: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    let requestModel = PostRequests()
    var dataList = [OrderList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.squareLoading.start(0)
        tableView.delegate = self
        tableView.dataSource = self
        
        requestModel.getOrdersList { [weak self] (data) in
            
            guard let daata = data else {
                self?.view.squareLoading.stop(0)
                return }
            DispatchQueue.main.async {
                self?.dataList = daata
                self?.tableView.reloadData()
                self?.view.squareLoading.stop(0)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OrderDetailsCell
        let data = dataList[indexPath.row]
        cell.orderNumLbl.text = "\(data.orderID)"
        let count = data.orderCartList?.count
        cell.numOfItems.text = "\(count ?? 0)"
        cell.DateOfOrder.text = data.currentState?.date_add
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //OrderDetailsVC
        let data = dataList[indexPath.row]

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailsVC") as! OrderDetailsVC
        vc.dataList = data
        vc.orderNumber = "\(data.orderID)"
        vc.numOfItems = "\( data.orderCartList?.count ?? 0)"
        vc.dateofOrders =  data.currentState?.date_add
        navigationController?.pushViewController(vc, animated: true )
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
