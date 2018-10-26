//
//  FavoritesTableViewCell.swift
//  Munchies
//
//  Created by Quinten Smith on 10/17/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    
    //MARK: - Outlets
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    
    //MARK: - Properties
    var recipe: RecipeWithDetailAndImage? {
        didSet {
            updateViews()
        }
    }
    
    
    //MARK: - UpdateViews
    func updateViews() {
        guard let recipe = recipe else {return}
        foodImageView.image = recipe.picture
        nameLabel.text = recipe.detailedRecipe.title
    }
}
