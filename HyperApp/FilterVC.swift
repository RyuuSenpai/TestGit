//
//  FilterVC.swift
//  HyperApp
//
//  Created by Killvak on 17/06/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit

class FilterVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var minPriceTxt: UITextField!
    @IBOutlet weak var maxPrice: UITextField!
    @IBOutlet weak var brandTxt: UITextField!
    @IBOutlet weak var categoryTxt: UITextField!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goSearch(_ query : String ,_ minPrice : String ,_ maxPrice : String) {
     
        guard !query.isEmpty ,!minPrice.isEmpty , !maxPrice.isEmpty else { return }
    
        let searchModel = PostRequests()
        searchModel.postSearchService(query: query, minPrice , maxPrice ) { [weak self ] (data) in
            
            if let data = data , data.count > 0 {
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "SeeMoreVC") as! SeeMoreVC
                vc.productsSearchArray = data
                
                self?.navigationController?.pushViewController(vc, animated: true )
            }
            
        }
        
    }
    @IBAction func searchBtn(_ sender: UIButton) {
        goSearch(searchTxt.text ?? "" , minPriceTxt.text ?? "",maxPrice.text ?? "" )
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
