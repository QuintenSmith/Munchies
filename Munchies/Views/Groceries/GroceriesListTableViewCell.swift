//
//  GroceriesListTableViewCell.swift
//  Munchies
//
//  Created by Quinten Smith on 10/18/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class GroceriesListTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - UpdateViews
    func updateViews() {
        guard let recipe = recipe else {return}
        nameLabel.text = recipe.recipeTitle
    }
    
    
    //MARK: - Action
    @IBOutlet weak var nameLabel: UILabel!
    
}
