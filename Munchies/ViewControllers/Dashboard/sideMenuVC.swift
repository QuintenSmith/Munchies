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
        sideMenu()

        var numberOfRows = 0
        if RecipeFetchController.shared.favoriteRecipies.count > 3 {
            numberOfRows = 3
        } else {
            numberOfRows = RecipeFetchController.shared.favoriteRecipies.count
        }
        
        let datasource = FavoritesTableViewDataSource(numberOfItems: numberOfRows, recipes: RecipeFetchController.shared.favoriteRecipies)
        tableView.dataSource = datasource
        NSLog("po %@", datasource)
        
        if datasource.numberOfItems >= 1 {
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
