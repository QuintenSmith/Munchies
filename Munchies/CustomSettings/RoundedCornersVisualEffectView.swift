//
//  RoundedCornersVisualEffectView.swift
//  Munchies
//
//  Created by Quinten Smith on 10/22/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//


import UIKit

class RoundedCornersVisualEffectView: UIVisualEffectView {
    
    override func awakeFromNib() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.layer.frame.width/2
    }
}
