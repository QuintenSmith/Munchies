//
//  FetchUserVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/23/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class FetchUserVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        performFetch()
    }
    
    func performFetch() {
        UserController.shared.fetchCurrentUser { (success) in
            if !success {
                DispatchQueue.main.async {
                    let createUserViewController = UIStoryboard(name: "CreateProfile", bundle: nil).instantiateViewController(withIdentifier: "kamil")
                   self.present(createUserViewController, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Quinten")
                    self.present(mainViewController, animated: true)
                }
            }
        }
    }

    

}
