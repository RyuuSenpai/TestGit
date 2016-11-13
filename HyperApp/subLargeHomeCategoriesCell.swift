//
//  subLargeHomeCategoriesCell.swift
//  HyperApp
//
//  Created by Killvak on 09/11/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import UIKit

class subLargeHomeCategoriesCell: UICollectionViewCell {

    @IBOutlet weak var categorytitle: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    var productCategory : ProductCategories? {
        didSet {
            if let categoryTitle = productCategory?.name {
                categorytitle.text = categoryTitle
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    

}
