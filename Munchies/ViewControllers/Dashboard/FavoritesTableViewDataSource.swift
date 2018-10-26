//
//  FavoritesTableViewDataSource.swift
//  Munchies
//
//  Created by Quinten Smith on 10/17/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class FavoritesTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    
    //MARK: - Properties
    var numberOfItems: Int = 0
    var recipes: [RecipeWithDetailAndImage]
    
    
    //MARK: - Initializer
    init(numberOfItems: Int, recipes: [RecipeWithDetailAndImage]) {
        self.numberOfItems = numberOfItems
        self.recipes = recipes
    }
    
    
    //MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if numberOfItems < recipes.count {
            return numberOfItems
        } else {
            return recipes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoritesTableViewCell
        let recipe = recipes[indexPath.row]
        cell?.recipe = recipe
        return cell ?? UITableViewCell()
    }
}
