//
//  BackTableVC.swift
//  HyperApp
//
//  Created by Killvak on 25/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import UIKit

class  BackTableVC : UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var SeugeIdArray = [String()]


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self 
        SeugeIdArray = ["HomePage","Wish List"]

    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SeugeIdArray.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SeugeIdArray[indexPath.row] , for: indexPath) as UITableViewCell
        
        
//        let newImage = resizeImage(image: image!, toTheSize:CGSize(width: 45, height: 45))


        return cell
    }
    
    
//    func resizeImage(image:UIImage, toTheSize size:CGSize)->UIImage{
//        
//        
//        let scale = CGFloat(max(size.width/image.size.width,
//                                size.height/image.size.height))
//        let width:CGFloat  = image.size.width * scale
//        let height:CGFloat = image.size.height * scale;
//        
//        let rr:CGRect = CGRect(x: 0, y: 0, width: width, height: height);
//        
//        UIGraphicsBeginImageContextWithOptions(size, false, 0);
//        image.draw(in: rr)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext();
//        return newImage!
//    }
}



