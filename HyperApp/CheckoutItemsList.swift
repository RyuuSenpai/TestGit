//
//  CheckoutItemsList.swift
//  HyperApp
//
//  Created by Killvak on 11/08/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit
import RealmSwift

class CheckoutItemsList : UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var checkoutOL: UIButton!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var totalPriceValue: UILabel!
    var totalPrice : Double = 0
    var locationData : LocationData?

 
 
    var items : [CDOnCart]?

    var ss : Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(collectionView)
//         view.addSubview(btn)
        tableView.delegate = self
        tableView.dataSource = self
         // Do any additional setup after loading the view.
        tableView.register(CheckListCell.self , forCellReuseIdentifier: "CellID")
          getTheData()
    }
    
    @IBAction func checkoutBtnAct(_ sender: UIButton) {
        
        let postRequest = PostReviewRequest()
        let parameter2 =  postOnCartItemData()
        guard let id = UserDefaults.standard.value(forKey: "User_ID") as? String else { print("nill in User_ID"); return }
        postRequest.postReqMakeOrder(userID: id, items: parameter2, completed: { [weak self] (true ) in
            print("DONE : checkOutBtnAct ")
            DispatchQueue.main.async {
                self?.view.isUserInteractionEnabled = false
                                  SweetAlert().showAlert("All Done", subTitle: "Confirmation call will reach you shortly.", style: AlertStyle.success)
                self?.deletaAllData()
            }

            // to run something in 0.1 seconds
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.41) {
                 self?.view.isUserInteractionEnabled = true 
                ad.reloadApp()

            }
        })
        
        
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

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = items?.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as! CheckListCell
        if let item = items?[indexPath.row] {
            
            cell.titleLabel.text = item.name
            cell.priceLabel.text = "\(item.price) L.E"
//            cell.t.text = item.name
            }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80;//Choose your custom row height
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func deletaAllData() {
        guard let data = items else { return }
        do {
            
            let realm = try Realm()
            
                     realm.beginWrite()
                    realm.delete(data)
                    try  realm.commitWrite()
           }catch let err as NSError {
            print(" saveCartData that is error :    \(err)")
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
            self.totalPriceLbl.text = "\(totalPrice) L.E"
            
       
            
            
            tableView.reloadData()
            
        }catch let err as NSError {
            print("that is error ya man   :   \(err)")
        }
        
    }
    
}

class CheckListCell : UITableViewCell {
//
//class CheckListCell : UITableView {
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
    
    //Locals
    let titleLabel : UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let priceLabel : UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
           lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let seprator : UIView = {
        let vw = UIView()
        vw.backgroundColor = .lightGray
           vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    //-----------------
    // MARK: VIEW FUNCTIONS
    //-----------------
    
    ///------------
    //Method: Init with Style
    //Purpose:
    //Notes: This will NOT get called unless you call "registerClass, forCellReuseIdentifier" on your tableview
    ///------------
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        //First Call Super
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Initialize Text Field
//        self.textField = UITextField(frame: CGRect(x: 119.00, y: 9, width: 216.00, height: 31.00));
    setupViews()
        //Add TextField to SubView
//        self.addSubview(self.textField)
    }
    
    
    func setupViews() {
          self.addSubview(titleLabel)
        self.addSubview(seprator)
        self.addSubview(priceLabel)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]-5-[v1(2)]-5-[v2(100)]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": titleLabel,"v1":seprator,"v2":priceLabel]))
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": titleLabel]))

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v1]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1":seprator]))

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v2]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v2":priceLabel]))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
