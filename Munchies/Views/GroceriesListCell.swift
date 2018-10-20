//
//  GroceriesListCell.swift
//  Munchies
//
//  Created by Quinten Smith on 10/19/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class GroceriesListCell: UITableViewCell {
    
    var isTapped: Bool = false
    
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var ingredientLbl: UILabel!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    
    func updateViews() {
        guard let recipe = recipe else {return}
        ingredientLbl.text = recipe.recipeTitle
    }
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
        if isTapped == false {
            deleteBtn.setBackgroundImage(#imageLiteral(resourceName: "shoppinglist"), for: .normal)
            isTapped = true
        } else {
            deleteBtn.setBackgroundImage(#imageLiteral(resourceName: "shoppinglist-1"), for: .normal)
            isTapped = false 
        }
    }
    
    

}
