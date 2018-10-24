//
//  RecipeVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

protocol RecipeVCDelegate: class{
    func setRecipeAsFavorite()
}


class RecipeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var reicpeTitleLabel: UILabel!
    @IBOutlet weak var recipeTimeToPrepareLabel: UILabel!
    @IBOutlet weak var portions: UILabel!
    @IBOutlet weak var recipeHeartButton: UIButton!
    
    
    //MARK: - Properties
    var recipeToDispaly : RecipeWithDetailAndImage?
    var recipeIndex: Int?
    
    var count: Int = 0
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ingredientTableView.delegate = self
        self.ingredientTableView.dataSource = self
        loadViewIfNeeded()
        updateViews()
        UINavigationBar.appearance().barTintColor = UIColor(red: 235/255, green: 111/255, blue: 100/255, alpha: 1)
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white 
        let titleLabel = UILabel()
        titleLabel.text = "Recipe"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: "Recipe", size: 12)
        self.navigationItem.titleView = titleLabel
        
        //set the heart lable base on its value
//        guard let index = recipeIndex else {return}
//        if RecipeFetchController.shared.filteredRecipiesWithDetailAndImage[index].detailedRecipe.isFavorite != nil {
//            if RecipeFetchController.shared.filteredRecipiesWithDetailAndImage[index].detailedRecipe.isFavorite! {
//                recipeHeartButton.setImage(#imageLiteral(resourceName: "favorites"), for: .normal)
//            } else {
//                recipeHeartButton.setImage(#imageLiteral(resourceName: "belowphotosoffood"), for: .normal)
//            }
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let ingredientCount = recipeToDispaly?.detailedRecipe.extendedIngredients?.count {
        if ingredientCount >= 1 {
            ingredientTableView.reloadData()
            ingredientTableView.scrollToRow(at: IndexPath(row: ingredientCount - 1 , section: 0), at: .bottom, animated: true)
            }
        }
    }
    
    
    //MARK: - Ingredients TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeToDispaly?.detailedRecipe.extendedIngredients?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? IngredientTableViewCell
        if let recipe = recipeToDispaly {
            let ingredientArray = recipe.detailedRecipe.extendedIngredients
            if let ingredientArray = ingredientArray {
                let ingredient = ingredientArray[indexPath.row].name
                cell?.ingredient = ingredient
            }
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
        guard let recipe = recipeToDispaly else {return}
        reicpeTitleLabel.text = recipe.detailedRecipe.title
        recipeTimeToPrepareLabel.text = "Ready in: \(String(recipe.detailedRecipe.readyInMinutes))min."
        if let servings = recipe.detailedRecipe.servings {
            portions.text = "Servings: \(String(servings))"
        }
        if let image = recipe.picture {
            recipeImageView.image = image
        }
        flipTheHeart()
    }
    
    
    @IBAction func heartButtonPressed(_ sender: Any) {
        print("pressing me")
        guard let recipe = recipeToDispaly else {return}
        if recipe.detailedRecipe.isFavorite != nil {
            recipe.detailedRecipe.isFavorite = !recipe.detailedRecipe.isFavorite!
            flipTheHeart()
            
            
        } else {
            
            //if favorite doesnt exist, assing it to true, and then flip th heart
            recipe.detailedRecipe.isFavorite = true
            //append it ot favorite array
            RecipeFetchController.shared.favoriteRecipies.append(recipe)
            print("assigned the heart property  to be true in RecipeVC ")
            flipTheHeart()
            
        }
        
    }
    
    
    func flipTheHeart(){
        guard let recipe = recipeToDispaly else {return}
        if recipe.detailedRecipe.isFavorite != nil {
            if recipe.detailedRecipe.isFavorite! == true {
                //favorite property is true
                print("changing heart to ❤️ in recipe detail VC")
                recipeHeartButton.setBackgroundImage(#imageLiteral(resourceName: "favorites"), for: .normal)
            } else if recipe.detailedRecipe.isFavorite! == false{
                //favorite property is false
                print("changing heart to 💙 in reciep detailVC")
                //remove it from array
                RecipeFetchController.shared.removefromFavorites(recipe: recipe)
                recipeHeartButton.setBackgroundImage(#imageLiteral(resourceName: "belowphotosoffood"), for: .normal)
            }
        }
        
    }
    
}
