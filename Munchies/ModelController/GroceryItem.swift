//
//  GroceryItem.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/22/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation


class GroceryItem: Equatable{
    
    var name: String
    var isSelected: Bool
    
    init(name: String, isSelected: Bool = false){
        self.name = name
        self.isSelected = isSelected
    }
    
    static func == (lhs: GroceryItem, rhs: GroceryItem) -> Bool {
        if lhs.name != rhs.name {return false}
        if lhs.isSelected != rhs.isSelected {return false}
        return true
    }
    
    
}
