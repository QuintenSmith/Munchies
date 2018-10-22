//
//  AppStylingController.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/21/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation

class AppStylingController {
    
    static let shared = AppStylingController()
    private init() {}
    
    //MARK: - Personal Settings Buttons Color
    //search filetr button colors
    let buttonUnselectedColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.5)
    let buttonSelectedColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 1.0)
    
}
