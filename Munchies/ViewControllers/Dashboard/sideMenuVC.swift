//
//  sideMenuVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/13/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class sideMenuVC: UIViewController, UITableViewDelegate {

    
     var numberOfItems: Int = 3
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        self.tableView.isHidden = true
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
    
    
    

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
    
    
    

    
}
