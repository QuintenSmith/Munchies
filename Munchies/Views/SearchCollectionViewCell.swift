//
//  SearchCollectionViewCell.swift
//  Munchies
//
//  Created by Quinten Smith on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var starsLbl: UILabel!
    @IBOutlet weak var recipeTitleLbl: UILabel!
    
    var cellData: Recipe? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        guard let recipe = cellData else {return}
        recipeImage.image = recipe.picture
        recipeTitleLbl.text = recipe.recipeTitle
        
        switch recipe.rating {
        case 1:
            starsLbl.text = "⭑"
        case 2:
            starsLbl.text = "⭑⭑"
        case 3:
            starsLbl.text = "⭑⭑⭑"
        case 4:
            starsLbl.text = "⭑⭑⭑⭑"
        case 5:
            starsLbl.text = "⭑⭑⭑⭑⭑"
        default:
            starsLbl.text = ""
        }
    }
    
    
}
