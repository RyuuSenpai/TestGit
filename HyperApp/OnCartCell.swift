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
    @IBOutlet weak var deleteRowDataBtn: UIButton!
    
    var onCart : CDOnCart? {
        didSet {
            if let title = onCart?.name {
                productTitle.text = title
            }
            if let quantity = onCart?.quantity {
                Productquantaty.text = "\(quantity)"
            }
            if let price = onCart?.qXprice , price > 0  {
                productPRice.text = "\(price) L.E"
            }else if let price = onCart?.price  {
                productPRice.text = "\(price) L.E"
            }
//            if let imageString = onCart?.imgString {
//                DispatchQueue.global(qos: .userInteractive).async { () -> Void in
//                    let imageUrl = URL(string: imageString)
//                    guard let url = imageUrl , let imageData = try? Data(contentsOf: url) else { return }
//                    let image = UIImage(data: imageData )
//                    
//                    DispatchQueue.main.async(execute: { () -> Void in
//                        self.productImage.image = image
//                    })
//                    
//                    
//                }
//            }
        }
    }
    override func prepareForReuse() {
         self.productImage.image = #imageLiteral(resourceName: "PlaceHolder")
        self.deleteRowDataBtn.setImage(#imageLiteral(resourceName: "uncheckBox"), for: UIControlState.normal)
        self.deleteRowDataBtn.titleLabel?.text = ""

    }
    
    func configCell( img : UIImage?){
    
        if let image = img {
            self.productImage.image = image
        }
    
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    @IBAction func stepperbtnAct(_ sender: UIStepper) {


        
    }
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
