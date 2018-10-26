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
    @IBOutlet weak var recipeHeartButton: UIButton!
    
    
    //MARK: - Properties
    var cellData: RecipeWithDetailAndImage? {
        didSet{
            updateViews()
        }
    }
    
    
    //MARK: - Helper Method to update Views
    func updateViews() {
        guard let recipe = cellData else {return}
        recipeImage.image = recipe.picture
        titleLabel.text = recipe.detailedRecipe.title
        readyInLabel.text = "Ready in: \(recipe.detailedRecipe.readyInMinutes) min."
        flipTheHeart()
    }
    
    func flipTheHeart(){
        guard let recipe = cellData else {
            print("no Data")
            return}
        if let isFavorite = recipe.detailedRecipe.isFavorite {
            if isFavorite {
                recipeHeartButton.setBackgroundImage(#imageLiteral(resourceName: "favorites"), for: .normal)
                return
            }
            recipeHeartButton.setBackgroundImage(#imageLiteral(resourceName: "belowphotosoffood"), for: .normal)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recipeHeartButton.setBackgroundImage(#imageLiteral(resourceName: "dashboardfavs"), for: .normal)
    }
}
