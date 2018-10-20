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
    @IBOutlet weak var cancelBtn: RoundedShapeButton!
    @IBOutlet weak var shareBtn: RoundedShapeButton!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    //var groceryItems = ["Apple", "Oranges", "Strawberries", "Water Melon","Grape", "Juice", "Banana", "Tomato"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        sideMenu()
    }
    
    func sideMenu() {
        if revealViewController() != nil {
            
            menuBtn.target = revealViewController()
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 325
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.layoutIfNeeded()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? GroceriesListCell
    //    let groceryItems = self.groceryItems[indexPath.row]
   //     cell?.ingredientLbl.text = groceryItems
        return cell ?? UITableViewCell()
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
    }
    
    

}
