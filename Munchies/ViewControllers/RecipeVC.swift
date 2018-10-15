//
//  RecipeVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class RecipeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cookwareTableView: UITableView!
    @IBOutlet weak var ingredientContentView: UIView!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    let cookware = ["Banana", "Banana", "Banana", "Banana", "Banana"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cookwareTableView.delegate = self
        self.cookwareTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cookware.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CookwareCell", for: indexPath)
        let cookware = self.cookware[indexPath.row]
        cell.textLabel?.text = cookware
        return cell 
    }
    
    
    @IBAction func cookwareBtnTapped(_ sender: Any) {
        cookwareTableView.isHidden = !cookwareTableView.isHidden
    }
    
    @IBAction func ingredientBtnTapped(_ sender: Any) {
           self.ingredientContentView.isHidden = !self.ingredientContentView.isHidden
    }
    
    @IBAction func instructionsBtnTapped(_ sender: Any) {
        instructionsTextView.isHidden = !instructionsTextView.isHidden
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    
    
    
}
