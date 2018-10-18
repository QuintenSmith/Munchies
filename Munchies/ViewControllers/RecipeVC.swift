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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var reicpeTitleLabel: UILabel!
    @IBOutlet weak var recipeTimeToPrepareLabel: UILabel!
    @IBOutlet weak var recipeLikesLabel: UILabel!
    
    
    //MARK: - Properties
    let ingredients = ["Banana", "Banana", "Banana", "Banana", "Banana"]
    var recipe : DetailedRecipe? {
        didSet{
            loadViewIfNeeded()
            updateViews()
        }
    }
    var recipeImage: UIImage?
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self 
    }
    
    
    //MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        let ingredients = self.ingredients[indexPath.row]
        cell.textLabel?.text = ingredients
        return cell 
    }
    
    
    //MARK: - Actions
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
    
    //MARK: - Helper method
    func updateViews() {
        
        guard let recipe = recipe, let image = recipeImage else {return}
       // recipeImageView.image = recipe.image
        reicpeTitleLabel.text = recipe.title
        recipeTimeToPrepareLabel.text = "Ready in: \(recipe.preparationMinutes) minutes."
        recipeLikesLabel.text = "NO Likes in Detail"
        recipeImageView.image = image
    }
    
    
}
