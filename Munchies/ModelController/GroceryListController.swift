//
//  GroceryListController.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/22/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation

class GroceryListController {
    
    //MARK: - Singelton
    static let shared = GroceryListController()
    private init() {}
    
    
    var groceries = [GroceryItem]()
    
    
    func addNew(grocery: GroceryItem){
        groceries.append(grocery)
    }
    
    func remove(grocery: GroceryItem){
        guard let index = groceries.index(of: grocery) else {return}
        groceries.remove(at: index)
    }
    
    
}
