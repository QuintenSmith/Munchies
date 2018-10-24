//
//  ComparePantryVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class ComparePantryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    #warning("Do We need this controller")
    
    let pantry = ["Apples", "Banana", "Eggplant", "Fennel", "Fettucine", "Sausage", "Spaghetti", "Tomatoe Sauce"]
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    //MARK: - TableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pantry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PantryCell", for: indexPath)
        let pantry = self.pantry[indexPath.row]
        cell.textLabel?.text = pantry
        return cell 
    }
    
    
    //MARK: - Actions
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
}
