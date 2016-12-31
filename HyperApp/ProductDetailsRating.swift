//
//  ItemDetailsRating.swift
//  HyperApp
//
//  Created by Killvak on 25/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import UIKit

extension ProductDetailsVC : FloatRatingViewDelegate {
    
    
    func RatingProtocoal() {
        
        
        // Required float rating view params
        self.floatRatingView.emptyImage = UIImage(named: "starempty")
        self.floatRatingView.fullImage = UIImage(named: "starfilled")
        // Optional params
        self.floatRatingView.delegate = self
        self.floatRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.floatRatingView.maxRating = 5
        self.floatRatingView.minRating = 1
        self.floatRatingView.rating = 2.5
        self.floatRatingView.editable = true
        self.floatRatingView.halfRatings = true
        self.floatRatingView.floatRatings = false
        
        
        // Segmented control init
        
        // Labels init
        CurrentRating = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float) {
        CurrentRating = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    
}
