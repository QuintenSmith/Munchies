//
//  IngredientTableViewCell.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/19/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {
    #warning("action is not working, plus print statement")
    
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
    
    
    @IBAction func addIngredientButtonPressed(_ sender: UIButton) {
        print("About to add ingredient")
        //need to add ingredint to shoping list here
        guard let user = UserController.shared.loggedInUser else {
            print("no user")
            return}
        guard let ingredient = ingredient else {
            print("no ingredient")
            return}
        ItemController.shared.createItem(user: user, item: ingredient) {(item) in
            print("Sucesfully added \(item) into grocery list")
        }
    }
    
    

}
