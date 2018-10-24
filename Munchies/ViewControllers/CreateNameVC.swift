//
//  CreateNameVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/23/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class CreateNameVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       nameTextField.delegate = self
    }
    
    @IBAction func nextBttonTapped(_ sender: Any) {
        guard nameTextField.text != ""  else { return }
        performSegue(withIdentifier: "toNextPage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNextPage" {
            if let destinationVC = segue.destination as? PreferencesVC {
                let name = self.nameTextField.text
                destinationVC.name = name 
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
}
