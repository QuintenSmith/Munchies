//
//  GroceriesListTableViewDataSource.swift
//  Munchies
//
//  Created by Quinten Smith on 10/18/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class GroceriesListTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var numberOfItems: Int
    var recipes: [Recipe]
    
    init(numberOfItems: Int, recipes: [Recipe]) {
        self.numberOfItems = numberOfItems
        self.recipes = recipes
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroceriesListCell", for: indexPath) as? GroceriesListTableViewCell
        let recipe = recipes[indexPath.row]
        cell?.recipe = recipe
        
        
        return cell ?? UITableViewCell()
    }

    
    
}
