//
//  SeeMoreCategories.swift
//  HyperApp
//
//  Created by Killvak on 20/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class SeeMoreCategories: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var categoriesData =  [GetAllCategoriesModel]()
    var pageNum  = 1 {
        didSet {
            self.fetchData()
        }
    }
    let dataRequest = ProductCategories()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.squareLoading.start(0)
fetchData()
        
        tableView.addInfiniteScroll { [weak self ](tableView) -> Void in
            // update table view
            self?.pageNum += 1
            // finish infinite scroll animation
            tableView.finishInfiniteScroll()
        }
    }
    
    func fetchData() {
        dataRequest.getAllCategories(pageNum: pageNum) { [weak self ] (data) in
            DispatchQueue.main.async {
                guard data.count > 0 else {
                    self?.tableView.removeInfiniteScroll()
                    return
                }
                self?.categoriesData.append(contentsOf: data)
                self?.tableView.reloadData()
                self?.view.squareLoading.stop(0)
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return categoriesData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        cell.textLabel?.text = categoriesData[indexPath.row].name
        return cell
    }
    

    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let seeMoreA = self.storyboard?.instantiateViewController(withIdentifier: "SeeMoreVC") as! SeeMoreVC
        seeMoreA.catID = categoriesData[indexPath.row].id
        navigationController?.pushViewController(seeMoreA, animated: true)
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
