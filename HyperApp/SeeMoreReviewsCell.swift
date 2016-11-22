//
//  SeeMoreReviewsCell.swift
//  HyperApp
//
//  Created by Killvak on 17/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class SeeMoreReviewsCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var ratingValue: UILabel!
    @IBOutlet weak var mainReview: UILabel!
    @IBOutlet weak var whatsGood: UILabel!
    @IBOutlet weak var whatsNotGood: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(data:String) {
        mainReview.text = data
    }

}
