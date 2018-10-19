//
//  IngredientTableViewCell.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/19/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var ingredientCheckMakrButton: UIButton!
    @IBOutlet weak var ingredientLabel: UILabel!
    
    var ingredient: String? {
        didSet{
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews() {
        ingredientLabel.text = ingredient
    }

}
