//
//  Intolerances.swift
//  Munchies
//
//  Created by Quinten Smith on 10/22/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation
import CloudKit

enum Intolerances: String, Hashable {
    
    static func == (lhs: Intolerances, rhs: Intolerances) -> Bool {
        return lhs.rawValue == rhs.rawValue 
    }

    case diary = "dairy"
    case peanut = "peanut"
    case soy = "soy"
    case egg = "egg"
    case seafood = "seafood"
    case sulfite = "sulfite"
    case gluten = "gluten"
    case sesame = "sesame"
    case shellfish = "shellfish"
    
}
