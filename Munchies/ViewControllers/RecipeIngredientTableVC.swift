//
//  RecipeIngredientTableVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class RecipeIngredientTableVC: UITableViewController {
    
    let ingredients = ["Banana", "Banana", "Banana", "Banana", "Banana"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        let ingredient = self.ingredients[indexPath.row]
        cell.textLabel?.text = ingredient
        return cell
    }

}
