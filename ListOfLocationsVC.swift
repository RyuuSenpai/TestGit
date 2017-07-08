//
//  ListOfLocationsVC.swift
//  HyperApp
//
//  Created by Killvak on 08/07/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit

class ListOfLocationsVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addAddressBtnOL: UIButtonX!

    var userId : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        title  = "Pick an Address"
        // Do any additional setup after loading the view.
        
        let requestClass = User_LocationModel()
        guard let id = UserDefaults.standard.value(forKey: "User_ID") as? String else { print("nill in User_ID"); return }
       
        userId = id
        requestClass.postUserAddress(userID: id) { 
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListOfLocationsCell

        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        }

    @IBAction func addAddressBtnAct(_ sender: UIButtonX) {
        let vc = CheckOutLocationVC(nibName: "CheckOutLocationVC", bundle: nil)
        vc.fName = "Eslam"
        vc.lastName = "Abo"
        vc.userId = userId
        self.navigationController?.pushViewController(vc, animated: true )

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


 class ListOfLocationsCell: UITableViewCell {
    
    @IBOutlet weak var addressLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
