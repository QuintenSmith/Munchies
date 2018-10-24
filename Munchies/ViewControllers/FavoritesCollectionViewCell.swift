//
//  FavoritesCollectionViewCell.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    //This is a custom coletion cell for the favorites list
    
    //MARK: - Properties
    
    // so basicly we need a model of type recipie, which is gone have image, dishname, and rating
    
        var cellData: RecipeWithDetailAndImage? {
        didSet{
            updateViews()
        }
    }
    
    
    //MARK: - Outlets
    @IBOutlet weak var favImageOutlet: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var mealNameLabel: UILabel!
    
    
    
    //MARK: - Helper Methods
    func updateViews(){
        guard let recipe = cellData else {return}
        favImageOutlet.image = recipe.picture
        mealNameLabel.text = recipe.detailedRecipe.title
        
        

        
        
    }
}
