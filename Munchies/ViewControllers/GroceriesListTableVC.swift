//
//  GroceriesListTableVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/18/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class GroceriesListTableVC: UITableViewController {
    
    var groceryItems = ["Apples", "Banana", "Eggplant", "Fennel", "Fettucine", "Sausage", "Spaghetti", "Tomato Sauce"]

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroceriesListCell", for: indexPath)
        let groceryItems = self.groceryItems[indexPath.row]
        cell.textLabel?.text = groceryItems
        return cell
    }
}
