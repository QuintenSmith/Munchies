//
//  GrocerieListVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/12/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class GrocerieListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, GroceriesListCellDelegate {
    
 
  
    
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelBtn: RoundedShapeButton!
    @IBOutlet weak var shareBtn: RoundedShapeButton!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var createNewGroceryItemTextField: UITextField!
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        createNewGroceryItemTextField.delegate = self
        sideMenu()
    }
    
    
    //MARK: - Side Menu Method
    func sideMenu() {
        if revealViewController() != nil {
            menuBtn.target = revealViewController()
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 325
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.layoutIfNeeded()
        }
    }
    
    
    //MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return GroceryListController.shared.groceries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath) as? GroceriesListCell
        let groceryItem = GroceryListController.shared.groceries[indexPath.row]
        cell?.grocery = groceryItem
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    //MARK: - Actions
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
        //remove groceries that have the button selected (isSelected = true) from the array of groceries, and reload tableview
        for grocery in GroceryListController.shared.groceries {
            if grocery.isSelected {
                GroceryListController.shared.remove(grocery: grocery)
            }
        }
        self.tableView.reloadData()
    }
    
    
    @IBAction func addNewGroceryItemButtonPressed(_ sender: Any) {
        guard let groceryName = createNewGroceryItemTextField.text, createNewGroceryItemTextField.text != "" else { return }
        let grocery = GroceryItem(name: groceryName)
        GroceryListController.shared.addNew(grocery: grocery)
        createNewGroceryItemTextField.text = ""
        self.tableView.reloadData()
    }
    
    
    
    
    
    
    //MARK: - Custom Protocol Conformance
    
    func updateGroceryItem(cell: GroceriesListCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let groceryItem = GroceryListController.shared.groceries[indexPath.row]
        groceryItem.isSelected = !groceryItem.isSelected
        tableView.reloadData()
    }
    
    
    //Helper Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        createNewGroceryItemTextField.resignFirstResponder()
        guard let groceryName = createNewGroceryItemTextField.text, createNewGroceryItemTextField.text != "" else {return true }
        let grocery = GroceryItem(name: groceryName)
        GroceryListController.shared.addNew(grocery: grocery)
        createNewGroceryItemTextField.text = ""
        self.tableView.reloadData()
        return true
    }
    
    

}
