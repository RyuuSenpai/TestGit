//
//  OrderDetailsCell.swift
//  HyperApp
//
//  Created by Killvak on 04/02/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit

class OrderDetailsCell: UITableViewCell {
    @IBOutlet weak var orderNumLbl: UILabel!
    @IBOutlet weak var numOfItems: UILabel!
    @IBOutlet weak var DateOfOrder: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
