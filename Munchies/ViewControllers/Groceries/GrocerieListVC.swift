//
//  GrocerieListVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/12/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class GrocerieListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, GroceriesListCellDelegate {
    
 
    var user: User?
    
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
        updateViews()
    }
    
    func updateViews() {
        guard let user = user else {return}
        UserController.shared.updateUser(user: user, name: user.name, diet: user.diet, intolerances: Set<String>(), shoppingList: user.shoppingList, favorites: user.favorites, journalEntries: user.journalEntries) { (success) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
            presntDeleteAlert()
    }
    
    @IBAction func addNewGroceryItemButtonPressed(_ sender: Any) {
        guard let groceryName = createNewGroceryItemTextField.text, createNewGroceryItemTextField.text != "" else { return }
        let grocery = GroceryItem(name: groceryName)
        GroceryListController.shared.addNew(grocery: grocery)
            self.tableView.reloadData()
            createNewGroceryItemTextField.text = ""
        updateViews()
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
        updateViews()
        self.tableView.reloadData()
        return true
    }
    
    func presntDeleteAlert(){
        let alert = UIAlertController(title: "Delete Grocery List", message: "Are you sure you want to delete selected items?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            for grocery in GroceryListController.shared.groceries {
                if grocery.isSelected {
                    GroceryListController.shared.remove(grocery: grocery)
                }
            }
            self.tableView.reloadData()
        }))
        self.present(alert, animated: true)
    }
}
