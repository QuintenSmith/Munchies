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
     var keyboardHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       nameTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //listen for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        //Stop lostening for keyboard events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    //MARK: - Keyboard Logic to move the view up.
    @objc func keyboardWillChange(notification: Notification){
        print("Keyboard will show: \(notification.name.rawValue)")
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardHeight
        } else {
            view.frame.origin.y = 0
        }
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
