//
//  MyProfileVC.swift
//  HyperApp
//
//  Created by Killvak on 20/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit
import StretchHeader
class MyProfileVC: UIViewController , UITableViewDelegate , UITableViewDataSource{
    @IBOutlet weak var sideMenuBOL: UIBarButtonItem!

    @IBOutlet weak var tableView: UITableView!
    var header : StretchHeader!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        if self.revealViewController() != nil {
            sideMenuBOL.target = self.revealViewController()
            sideMenuBOL.action = #selector(SWRevealViewController.revealToggle(_:))
            //     self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        setupHeaderView()
    }
    
    func setupHeaderView() {
        
        let options = StretchHeaderOptions()
        options.position = .underNavigationBar
        
        header = StretchHeader()
        header.stretchHeaderSize(headerSize: CGSize(width: view.frame.size.width, height: 220),
                                 imageSize: CGSize(width: view.frame.size.width, height: 220),
                                 controller: self,
                                 options: options)
        header.imageView.image = UIImage(named: "1")
        
        
        // custom
        
        let avatarImage = UIImageView()
        avatarImage.frame = CGRect(x: 10, y: header.imageView.frame.height / 2 , width: 100, height: 100)
        avatarImage.image = UIImage(named: "2")
        avatarImage.layer.cornerRadius = 5.0
        avatarImage.layer.borderColor = UIColor.white.cgColor
        avatarImage.layer.borderWidth = 3.0
        avatarImage.clipsToBounds = true
        avatarImage.contentMode = .scaleAspectFill
        header.addSubview(avatarImage)
        /*
        let label = UILabel()
        label.frame = CGRect(x: 10, y: header.frame.size.height - 40, width: header.frame.size.width - 20, height: 40)
        label.textColor = UIColor.white
        label.text = "StrechHeader Demo"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        header.addSubview(label)
        */
        tableView.tableHeaderView = header
    }
    
    // MARK: - ScrollView Delegate
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        header.updateScrollViewOffset(scrollView)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.red
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
