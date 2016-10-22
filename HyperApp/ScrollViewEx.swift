//
//  ScrollViewEx.swift
//  Auk
//
//  Created by Killvak on 18/10/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    var currentPage:Int{
        return Int((self.contentOffset.x+(0.5*self.frame.size.width))/self.frame.width)
    }
}
