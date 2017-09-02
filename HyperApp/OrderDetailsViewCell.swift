//
//  OrderDetailsViewCell.swift
//  HyperApp
//
//  Created by Killvak on 04/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit

class OrderDetailsViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var discountValueinPercent: UILabel!
    @IBOutlet weak var quantity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
