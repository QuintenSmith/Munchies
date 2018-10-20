//
//  RecipeVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class RecipeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var reicpeTitleLabel: UILabel!
    @IBOutlet weak var recipeTimeToPrepareLabel: UILabel!
    @IBOutlet weak var portions: UILabel!
    
    //MARK: - Properties
    let recipe = RecipeFetchController.shared.recipeForDetailView
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ingredientTableView.delegate = self
        self.ingredientTableView.dataSource = self
        loadViewIfNeeded()
        updateViews()
    }
    
    
    //MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeFetchController.shared.recipeForDetailView?.recipe.extendedIngredients?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? IngredientTableViewCell
        let ingredientArray = RecipeFetchController.shared.recipeForDetailView?.recipe.extendedIngredients
        if let ingredientArray = ingredientArray {
        let ingredient = ingredientArray[indexPath.row].name
        cell?.ingredient = ingredient
        } else {
            print("‼️ No Ingredients found")
        }
        return cell ?? UITableViewCell()
    }
    
    
    //MARK: - Actions
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
    
    
    //MARK: - Helper method
    func updateViews() {
        guard let recipe = recipe else {return}
        reicpeTitleLabel.text = recipe.recipe.title
        #warning ("Used exclamation to unwrap value")
        portions.text = "\(recipe.recipe.servings!)"
        recipeImageView.image = recipe.picture
        guard let readyinMinutes = recipe.recipe.preparationMinutes else {
            print("❕ returned from unwraping Recipe Preparation in minutes on RecipeVC")
            return  }
        recipeTimeToPrepareLabel.text = "\(readyinMinutes) minutes."
    }
    
    
}
