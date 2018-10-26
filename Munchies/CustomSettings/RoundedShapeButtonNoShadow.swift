//
//  RoundedShapeButtonNoShadow.swift
//  Munchies
//
//  Created by Quinten Smith on 10/24/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class RoundedShapeButtonNoShadow: UIButton {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 6
    }
    
}
