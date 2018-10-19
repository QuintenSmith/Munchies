//
//  JournalDashboardCollectionViewCell.swift
//  Munchies
//
//  Created by Quinten Smith on 10/18/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class JournalDashboardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard  let recipe = recipe else {return}
        imageView.image = recipe.picture
        nameLabel.text = recipe.recipeTitle
        timeLabel.text = "\(recipe.rating)"
    }
}
