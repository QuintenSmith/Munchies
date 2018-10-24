//
//  RoundedImageView.swift
//  Munchies
//
//  Created by Quinten Smith on 10/19/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class RoundedShadowImageView: UIImageView {
    
    override func awakeFromNib() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 22
        self.layer.shadowOpacity = 0.75
        self.layer.cornerRadius = 4
    }
    
}
