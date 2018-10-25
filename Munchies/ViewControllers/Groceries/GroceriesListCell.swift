//
//  GroceriesListCell.swift
//  Munchies
//
//  Created by Quinten Smith on 10/19/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

protocol GroceriesListCellDelegate: class{
    func updateGroceryItem(cell: GroceriesListCell)
}



class GroceriesListCell: UITableViewCell {
    
    
    //MARK: - Properties
    weak var delegate : GroceriesListCellDelegate?
    var grocery: Item? {
        didSet {
            updateViews()
        }
    }
    
    
    //MARK: - Outlets
    @IBOutlet weak var checkMarkButton: UIButton!
    @IBOutlet weak var ingredientLbl: UILabel!
    
    
    //MARK: - Actions
    @IBAction func checkMArkButtonTapped(_ sender: Any) {
        self.delegate?.updateGroceryItem(cell: self)
    }
    
    
    //MARK: - Helper Methods
    func setCheckMarkButtonImage(){
        guard let grocery = grocery else {
            print("No Groceries for updating Checkmark button")
            return}
        if grocery.isSelected {
            checkMarkButton.setBackgroundImage(#imageLiteral(resourceName: "shoppinglist"), for: .normal)
        } else if !grocery.isSelected{
            checkMarkButton.setBackgroundImage(#imageLiteral(resourceName: "shoppinglist-1"), for: .normal)
        }
    }
    
    func updateViews() {
        guard let grocery = grocery else {
            print("No groceries - cant update views")
            return}
        ingredientLbl.text = grocery.name
        setCheckMarkButtonImage()
    }
}
