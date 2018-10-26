//
//  RoundedBottomView.swift
//  Munchies
//
//  Created by Quinten Smith on 10/22/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class RoundedBottomView: UIView {
    
    override func awakeFromNib() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 6
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
//    yourView.clipsToBounds = true
//    yourView.layer.cornerRadius = 10
//    yourView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
}
