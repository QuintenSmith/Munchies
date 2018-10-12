//
//  GrocerieListVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/12/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class GrocerieListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var groceryDictionary = [String: [String]]()
    var grocerySectionTitles = [String]()
    var groceryItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return grocerySectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemKey = grocerySectionTitles[section]
        if let groceryValues = groceryDictionary[itemKey] {
            return groceryValues.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let itemKey = grocerySectionTitles[indexPath.section]
        if let groceryValues = groceryDictionary[itemKey] {
            cell.textLabel?.text = groceryValues[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return grocerySectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return grocerySectionTitles
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
    }
    
    

}
