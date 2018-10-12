//
//  CameraVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/12/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class CameraVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    let list = ["peach", "banana", "apple", "grape"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        let listItem = list[indexPath.row]
        cell.textLabel?.text = listItem
        return cell 
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
    }
    
    
    @IBAction func addBtnPressed(_ sender: Any) {
    }
    
}
