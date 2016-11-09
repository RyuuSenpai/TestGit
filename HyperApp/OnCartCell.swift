//
//  OnCartTableViewCell.swift
//  HyperApp
//
//  Created by Killvak on 06/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit


class OnCartCell: UITableViewCell {

    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPRice: UILabel!
    
    @IBOutlet weak var Productquantaty: UILabel!
    
    @IBOutlet weak var discountPercent: UILabel!
    @IBOutlet weak var addToQuantity: UIButton!
    @IBOutlet weak var removeFromQuantity: UIButton!
    
    var onCart : CDOnCart? {
        didSet {
            if let title = onCart?.name {
                productTitle.text = title
            }
            if let quantity = onCart?.quantity {
                Productquantaty.text = "\(quantity)"
            }
            if let price = onCart?.qXprice   {
                productPRice.text = "\(price) L.E"
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    @IBAction func stepperbtnAct(_ sender: UIStepper) {

        Productquantaty.text = Int(sender.value).description
    
        onCart?.quantity =  Int16(sender.value)
        ad.saveContext()
        
    }
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
