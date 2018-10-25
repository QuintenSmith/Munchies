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
    var grocery: Item?
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelBtn: RoundedShapeButton!
    @IBOutlet weak var shareBtn: RoundedShapeButton!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var createNewGroceryItemTextField: UITextField!
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        user = UserController.shared.loggedInUser
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        createNewGroceryItemTextField.delegate = self
        sideMenu()
        tableView.keyboardDismissMode = .onDrag
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let user = UserController.shared.loggedInUser else {return}
        ItemController.shared.fetchItemsfor(user: user) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
       }

    }
    
    func updateViews() {
        print("updating views")
        guard let user = user else {
            print("user not found in the updateViews method in GroceriesListVC")
            return}
        print("updating user: \(user)")
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
        return user?.shoppingList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath) as? GroceriesListCell
        let groceryItem = user?.shoppingList![indexPath.row]
        cell?.grocery = groceryItem
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    
    //MARK: - Actions    
//    @IBAction func shareButtonPressed(_ sender: Any) {
//        if !GroceryListController.shared.groceries.isEmpty {
//            var groceriesAsText = ""
//            var groceries = [String]()
//            for grocery in GroceryListController.shared.groceries {
//                    groceries.append(grocery.name)
//            }
//            groceriesAsText = groceries.joined(separator: ",\n")
//            print(groceriesAsText)
//            let shareSheet = UIActivityViewController(activityItems: [groceriesAsText], applicationActivities: nil)
//            present(shareSheet, animated: true, completion: nil)
//        } else {
//            let alert = UIAlertController(title: "Nothing to share", message: "Please add some items to shopping list.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            present(alert, animated: true)
//        }
//    }
//    
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
            presntDeleteAlert()
    }
    
    @IBAction func addNewGroceryItemButtonPressed(_ sender: Any) {
        guard let item = createNewGroceryItemTextField.text, createNewGroceryItemTextField.text != "" else { return }
        if let user = user {
            ItemController.shared.createItem(user: user, item: item) { (_) in
                DispatchQueue.main.async {
                    self.createNewGroceryItemTextField.text = ""
                    self.tableView.reloadData()
                }
            }
        }
            self.tableView.reloadData()
            createNewGroceryItemTextField.text = ""
    }
    
    
    //MARK: - Custom Protocol Conformance
    func updateGroceryItem(cell: GroceriesListCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        guard let groceryItem = user?.shoppingList![indexPath.row] else {return}
        groceryItem.isSelected = !groceryItem.isSelected
        tableView.reloadData()
    }
    
    
    //Helper Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        createNewGroceryItemTextField.resignFirstResponder()
        guard let item = createNewGroceryItemTextField.text, createNewGroceryItemTextField.text != "" else {return true }
        if let user = user {
        ItemController.shared.createItem(user: user, item: item) { (_) in
            DispatchQueue.main.async {
                self.createNewGroceryItemTextField.text = ""
                self.tableView.reloadData()
            }
          }
        }
        return true
}
    
    func presntDeleteAlert(){
        let alert = UIAlertController(title: "Delete Grocery List", message: "Are you sure you want to delete selected items?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            for item in (self.user?.shoppingList)! {
                if item.isSelected == true {
                    let index = self.user?.shoppingList!.index(of: item)
                    self.user?.shoppingList?.remove(at: index!)
                    ItemController.shared.deleteItem(item: item, index: index!)
                    self.tableView.reloadData()
                }
            }
            self.tableView.reloadData()
        }))
        self.present(alert, animated: true)
    }
}

