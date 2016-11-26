//
//  MyProfileCellHeader.swift
//  
//
//  Created by Killvak on 22/11/2016.
//
//
import UIKit

class MyProfileCellHeader: UITableViewCell {

    @IBOutlet weak var BoughtItems: UILabel!
    @IBOutlet weak var favItems: UILabel!
    @IBOutlet weak var onCartCount: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(model : ProfileHeaderM) {
    
        if let fav = model.favCount {
            favItems.text = fav
        }
        if let cart = model.itemsOnCart {
            onCartCount.text = cart
        }
        if let bought = model.boughtItemsCount {
            BoughtItems.text = bought
        }
        profileImage.image = model.image
        guard   profileImage.image != UIImage(named: "Ninja Head") else { return }
        profileImage.layer.cornerRadius = 20
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 5.0
        profileImage.layer.borderColor = UIColor.white.cgColor
        
    }
    func updateUI() {
        
    }

}


