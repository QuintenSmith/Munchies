//
//  CustomCellRoundedImages.swift
//  Munchies
//
//  Created by Quinten Smith on 10/22/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class CustomCellRoundedImages: UIImageView {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
}

