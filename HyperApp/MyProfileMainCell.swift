//
//  MyProfileMainCell.swift
//  HyperApp
//
//  Created by Killvak on 22/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class MyProfileMainCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(name:String? , imageName  :String?) {
        if let title = name {
            self.title.text = title
        }
        if let imageName = imageName {
            iconImage.image = UIImage(named:imageName)
            
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
