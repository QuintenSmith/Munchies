//
//  FavoritesTableViewCell.swift
//  Munchies
//
//  Created by Quinten Smith on 10/17/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let recipe = recipe else {return}
        foodImageView.image = recipe.picture
        nameLabel.text = recipe.recipeTitle
        likesLabel.text = "\(recipe.rating)"
    }
}
