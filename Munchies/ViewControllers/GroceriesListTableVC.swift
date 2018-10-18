//
//  GroceriesListTableVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/18/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class GroceriesListTableVC: UITableViewController {
    
    var groceryDictionary = [String: [String]]()
    var grocerySectionTitles = [String]()
    var groceryItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        groceryItems = ["Apple", "Oranges", "Strawberries", "Water Melon","Grape", "Juice", "Banana", "Tomato"]
        
        for item in groceryItems {
            let itemKey = String(item.prefix(1))
            if var groceryValues = groceryDictionary[itemKey] {
                groceryValues.append(itemKey)
                groceryDictionary[itemKey] = groceryValues
            } else {
                groceryDictionary[itemKey] = [item]
            }
        }
        
        grocerySectionTitles = [String](groceryDictionary.keys)
        grocerySectionTitles = grocerySectionTitles.sorted(by: { $0 < $1 })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return grocerySectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemKey = grocerySectionTitles[section]
        if let groceryValues = groceryDictionary[itemKey] {
            return groceryValues.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroceriesLIstCell", for: indexPath)
        let itemKey = grocerySectionTitles[indexPath.section]
        if let groceryValues = groceryDictionary[itemKey] {
            cell.textLabel?.text = groceryValues[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return grocerySectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return grocerySectionTitles
    }

}
