//
//  ProductReviewCell.swift
//  HyperApp
//
//  Created by Killvak on 26/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class ProductReviewCell: UICollectionViewCell {
    
    @IBOutlet weak var emailPlaceHolder: UILabel!
    
    @IBOutlet weak var ratePlaceHolder: UILabel!
    
    @IBOutlet weak var dateOfReview: UILabel!
    
    @IBOutlet weak var reviewTextPlaceHolder: UILabel!
    
    
    
    func configCell(data : GetItemReviewModel) {
        
        self.emailPlaceHolder.text = data.userData?.fullname
        self.ratePlaceHolder.text =  "\(data.rate)"
        self.dateOfReview.text = data.dateAdd
        self.reviewTextPlaceHolder.text = data.review
    }
    
    
}
