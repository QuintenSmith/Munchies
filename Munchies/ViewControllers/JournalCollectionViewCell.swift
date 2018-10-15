//
//  JournalCollectionViewCell.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class JournalCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dishNameLabel: UILabel!
    
    
    //MARK: - Properties
    var cellData: Recipe? {
        didSet{
            updateViews()
        }
    }
    
    
    
    //MARK: - Helper Methods
    func updateViews(){
        guard let recipe = cellData else {return}
        pictureView.image = recipe.picture
        dishNameLabel.text = recipe.recipeTitle
        
        
        
        switch recipe.rating {
        case 1:
            ratingLabel.text = "⭑"
        case 2:
            ratingLabel.text = "⭑⭑"
        case 3:
            ratingLabel.text = "⭑⭑⭑"
        case 4:
            ratingLabel.text = "⭑⭑⭑⭑"
        case 5:
            ratingLabel.text = "⭑⭑⭑⭑⭑"
        default:
            ratingLabel.text = ""
        }
    }
    
    
    
    
}
