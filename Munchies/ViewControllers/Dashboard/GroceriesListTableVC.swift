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
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        user = UserController.shared.loggedInUser
        ItemController.shared.fetchItemsfor(user: user!) { (success) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        tableView.backgroundView = backgroundImg
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let shoppingList = user?.shoppingList else {return}
        if shoppingList.count == 0 {
            self.tableView.backgroundView?.isHidden = false
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        guard let shoppingList = user?.shoppingList else {return}
        if shoppingList.count >= 1 {
            self.tableView.backgroundView?.isHidden = true
        } else {
            self.tableView.backgroundView?.isHidden = false
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.shoppingList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroceriesListCell", for: indexPath)
        let groceryItem = user?.shoppingList![indexPath.row]
        cell.textLabel?.text = groceryItem?.name
        return cell
    }
}
