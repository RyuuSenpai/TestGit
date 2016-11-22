//
//  SeeReviews.swift
//  HyperApp
//
//  Created by Killvak on 17/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class SeeReviews: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var testData = ["Very good product , but it all depends Very good product , but it all depends ", "Very good product , but it all depends" , "Very good product , but it all depends Very good product , but it all depends Very good product , but it all dependsbut it all depends Very good product , but it all dependsbut it all depends Very good product , but it all dependsbut it all depends Very good product , but it all dependsbut it all depends Very good product , but it all depends " ,"Very good product , but it all depends","Very good product , but it all depends","Very good product , but it all depends"]
    var indexIs : Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = 228
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! SeeMoreReviewsCell
        cell.configCell(data: testData[indexPath.row])
        return cell
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
