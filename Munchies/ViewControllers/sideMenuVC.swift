//
//  sideMenuVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/13/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class sideMenuVC: UIViewController {
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu()
    }

    func sideMenu() {
        if revealViewController() != nil {
            
            menuBtn.target = revealViewController()
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.layoutIfNeeded()
        }
    }

}
