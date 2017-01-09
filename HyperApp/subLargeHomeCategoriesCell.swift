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
            //Stage API
//            if let categoryTitle = productCategory?.name {
//                categorytitle.text = categoryTitle
//            }
            if let catData = productCategory?.catDetails {
                
                    categorytitle.text = catData.name
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
