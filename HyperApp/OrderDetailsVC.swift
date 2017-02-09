//
//  OrderDetailsVC.swift
//  HyperApp
//
//  Created by Killvak on 04/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit

class OrderDetailsVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        roundedCournersTableView()
        // Do any additional setup after loading the view.
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OrderDetailsViewCell
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
