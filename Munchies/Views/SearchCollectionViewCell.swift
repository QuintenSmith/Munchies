//
//  SearchCollectionViewCell.swift
//  Munchies
//
//  Created by Quinten Smith on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: - Outlets
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var readyInLabel: UILabel!
    
    
    //MARK: - Properties
    var cellData: DetailedRecipe? {
        didSet{
            updateViews()
        }
    }
    
    var thumbnail : UIImage? {
        didSet{
            updateViews()
        }
    }
    
    //MARK: - Helper Method to update Views
    func updateViews() {
        guard let recipe = cellData else {return}
        recipeImage.image = thumbnail
        titleLabel.text = recipe.title
        readyInLabel.text = "Ready in: \(recipe.readyInMinutes) min."
    }
    
    
}
