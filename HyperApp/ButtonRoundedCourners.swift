//
//  ButtonRoundedCourners.swift
//  HyperApp
//
//  Created by Killvak on 19/12/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import UIKit
class ButtonRoundedCourners : UIButton {
    
    required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    layer.borderWidth = 1.0
    layer.borderColor = UIColor.white.cgColor
    layer.cornerRadius = 5.0
    clipsToBounds = true
        self.back
    contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    setTitleColor(tintColor, for: .normal)
    setTitleColor(UIColor.white, for: .highlighted)
    }
}
