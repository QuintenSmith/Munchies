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
    
    //MARK: - Properties
    var ingredient: String? {
        didSet{
            updateViews()
        }
    }
    
    //MARK: - LifeCycle Methods
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
    
    
    //MARK: - Actions
    @IBAction func addIngredientButtonPressed(_ sender: UIButton) {
        guard let user = UserController.shared.loggedInUser else {
            return}
        guard let ingredient = ingredient else {
            return}
        
        let item = Item(name: ingredient, user: user)
        if let shoppingList = user.shoppingList {
            if shoppingList.contains(item) {
            } else {
                ItemController.shared.createItem(user: user, item: ingredient) {(item) in
                }
            }
        } else {
            ItemController.shared.createItem(user: user, item: ingredient) {(item) in
            }
        }
    }
}
