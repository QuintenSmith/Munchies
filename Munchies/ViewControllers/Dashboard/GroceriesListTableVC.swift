//
//  GroceriesListTableVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/18/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class GroceriesListTableVC: UITableViewController {
    
    @IBOutlet var backgroundImg: UIView!
    
    //var groceryItems: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = backgroundImg
        if GroceryListController.shared.groceries.count >= 1 {
            self.tableView.backgroundView?.isHidden = true
        } else {
            self.tableView.backgroundView?.isHidden = false
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroceryListController.shared.groceries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroceriesListCell", for: indexPath)
        let groceryItems = GroceryListController.shared.groceries[indexPath.row]
        cell.textLabel?.text = groceryItems.name
        return cell
    }
}
