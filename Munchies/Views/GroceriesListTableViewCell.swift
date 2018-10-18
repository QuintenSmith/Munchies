//
//  GroceriesListTableViewCell.swift
//  Munchies
//
//  Created by Quinten Smith on 10/18/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class GroceriesListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let recipe = recipe else {return}
        nameLabel.text = recipe.recipeTitle
        
    }
}
