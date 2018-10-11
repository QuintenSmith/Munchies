//
//  FilterVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/10/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class FilterVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var timeButtons: [UIButton]!
    @IBOutlet var portionStackViews: [UIStackView]!
    @IBOutlet var portionButtons: [UIButton]!
    @IBOutlet weak var difficultyBtnStackView: UIStackView!
    
    
    
    var pantryDictionary = [String: [String]]()
    var pantrySectionTitles = [String]()
    var pantryItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        pantryItems = ["Apple", "Banana", "Oranges", "Strawberries", "Water Melon", "Seasoning" ,"Grape", "Juice", "Sauce", "Banana"]
        
        for item in pantryItems {
            let itemKey = String(item.prefix(1))
            if var pantryValues = pantryDictionary[itemKey] {
                pantryValues.append(itemKey)
                pantryDictionary[itemKey] = pantryValues
            } else {
                pantryDictionary[itemKey] = [item]
            }
        }
        
        pantrySectionTitles = [String](pantryDictionary.keys)
        pantrySectionTitles = pantrySectionTitles.sorted(by: { $0 < $1 })
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return pantrySectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemKey = pantrySectionTitles[section]
        if let pantryValues = pantryDictionary[itemKey] {
            return pantryValues.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let itemKey = pantrySectionTitles[indexPath.section]
        if let pantryValues = pantryDictionary[itemKey] {
            cell.textLabel?.text = pantryValues[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return pantrySectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return pantrySectionTitles
    }
    
    @IBAction func handleSelection(_ sender: UIButton) {
        timeButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
              button.isHidden = !button.isHidden
              self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func portionSelection(_ sender: Any) {
        portionStackViews.forEach { (stackView) in
            UIView.animate(withDuration: 0.1, animations: {
            stackView.isHidden = !stackView.isHidden
            self.view.layoutIfNeeded()
          })
        }
    }
    
    
    @IBAction func pantryButtonTapped(_ sender: Any) {
        tableView.isHidden = !tableView.isHidden
    }
    
    @IBAction func difficultyBtnTapped(_ sender: Any) {
        difficultyBtnStackView.isHidden = !difficultyBtnStackView.isHidden
    }
    
    
    @IBAction func timeBtnTapped(_ sender: UIButton) {
        
    }
    

}
