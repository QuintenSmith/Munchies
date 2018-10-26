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
        
    //MARK: - LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.backgroundView = self.backgroundImg
        guard let user = UserController.shared.loggedInUser else {return}
        ItemController.shared.fetchItemsfor(user: user) { (success) in
            if success {
                DispatchQueue.main.async {
                    guard let shoppingList = user.shoppingList else {return}
                    if shoppingList.count >= 1 {
                        self.tableView.backgroundView?.isHidden = true
                    } else {
                        self.tableView.backgroundView?.isHidden = false
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let user = UserController.shared.loggedInUser else {return 0}
        guard let shoppingList = user.shoppingList else {return 0}
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let user = UserController.shared.loggedInUser else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroceriesListCell", for: indexPath)
        let groceryItem = user.shoppingList![indexPath.row]
        cell.textLabel?.text = groceryItem.name
        return cell
    }
}
