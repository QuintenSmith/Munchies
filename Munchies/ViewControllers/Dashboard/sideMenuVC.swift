//
//  sideMenuVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/13/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class sideMenuVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        self.tableView.isHidden = true
        
        sideMenu()
        
        let datasource = FavoritesTableViewDataSource(numberOfItems: 2, recipes: RecipeFetchController.shared.favoriteRecipies)
        tableView.dataSource = datasource
        NSLog("po %@", datasource)
        
        if RecipeFetchController.shared.favoriteRecipies.count >= 1 {
            self.tableView.isHidden = false
        }
        
        tableView.reloadData()
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
    
    
    

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
    
    
    

    
}
