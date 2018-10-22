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
    
  //  var isTapped: Bool = false
    weak var delegate : GroceriesListCellDelegate?
    
    @IBOutlet weak var checkMarkButton: UIButton!
    @IBOutlet weak var ingredientLbl: UILabel!
    
    var grocery: GroceryItem? {
        didSet {
            updateViews()
        }
    }
    
    
    func updateViews() {
        guard let grocery = grocery else {
            print("No groceries - cant update views")
            return}
        ingredientLbl.text = grocery.name
       setCheckMarkButtonImage()
    }
    
    
    
    @IBAction func checkMArkButtonTapped(_ sender: Any) {
        // need delegate to to comunicate with vc that this button was tapped so the vc can update the model
      //  guard let groceryisSelected = grocery?.isSelected else {return}
  
        self.delegate?.updateGroceryItem(cell: self)
        
    }
    
    
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
    

}
