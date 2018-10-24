//
//  RoundedImageViewCustomCells.swift
//  Munchies
//
//  Created by Quinten Smith on 10/22/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class RoundedImageViewCustomCells: UIImageView {
    
    override func awakeFromNib() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 4.0
    }
}
