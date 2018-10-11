//
//  ProfileViewController.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/10/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    //MARK: - Outletds
    @IBOutlet weak var medicalPlusButtonOutlet: UIButton!
    @IBOutlet weak var dietaryPlusButtonOutlet: UIButton!
    @IBOutlet weak var utensilPlusButtonOutlet: UIButton!
    @IBOutlet weak var medicalSensitivityViewConstraintOutlet: NSLayoutConstraint!
    @IBOutlet weak var dietaryRestrictionsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var utensilsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var enterEmailTextField: UITextField!
    @IBOutlet weak var enterNameTextField: UITextField!
    @IBOutlet weak var lightBlueStackView: UIStackView!
    @IBOutlet weak var darkBlueStackView: UIStackView!
    @IBOutlet weak var yellowStackView: UIStackView!
    @IBOutlet weak var editButtonOutlet: UIButton!
    
    
    //MARK: - Properties
    var isEditingEnabled: Bool = false
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        lightBlueStackView.isHidden = true
        darkBlueStackView.isHidden = true
        yellowStackView.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    //MARK: - Actions
    @IBAction func medicalSensitivitiesButtonPressed(_ sender: Any) {
        if medicalSensitivityViewConstraintOutlet.constant == 48.9 {
            UIView.animate(withDuration: 1) {
                self.medicalSensitivityViewConstraintOutlet.constant = 320
                self.medicalPlusButtonOutlet.setTitle("-", for: .normal)
                self.yellowStackView.isHidden = false
            }
        } else {
            self.medicalSensitivityViewConstraintOutlet.constant = 48.9
            self.medicalPlusButtonOutlet.setTitle("+", for: .normal)
            self.yellowStackView.isHidden = true
        }
    }
    
    @IBAction func dietaryRestrictionsButtonPressed(_ sender: UIButton) {
        if self.dietaryRestrictionsViewHeightConstraint.constant == 48.9 {
            UIView.animate(withDuration: 1) {
                self.dietaryRestrictionsViewHeightConstraint.constant = 320
                self.dietaryPlusButtonOutlet.setTitle("-", for: .normal)
                self.lightBlueStackView.isHidden = false
                //lightBlueStackView.isHidden = !lightBlueStackView.isHidden
            }
        } else {
            self.dietaryRestrictionsViewHeightConstraint.constant = 48.9
            self.dietaryPlusButtonOutlet.setTitle("+", for: .normal)
            self.lightBlueStackView.isHidden = true
        }
    }
    
    @IBAction func utensilsButtonPressed(_ sender: Any) {
        if utensilsViewHeightConstraint.constant == 48.9 {
            UIView.animate(withDuration: 5) {
                self.utensilsViewHeightConstraint.constant = 320
                self.utensilPlusButtonOutlet.setTitle("-", for: .normal)
                self.darkBlueStackView.isHidden = false
            }
        } else {
            self.utensilsViewHeightConstraint.constant = 48.9
            self.utensilPlusButtonOutlet.setTitle("+", for: .normal)
            self.darkBlueStackView.isHidden = true
        }
    }
    
    
    @IBAction func editButtonTapped(_ sender: Any) {
        
        isEditingEnabled = !isEditingEnabled
        
        if isEditingEnabled {
            editButtonOutlet.setTitle("Done", for: .normal)
            emailLabel.isHidden = true
            nameLabel.isHidden = true
            enterEmailTextField.isHidden = false
            enterNameTextField.isHidden = false
            
        } else if !isEditingEnabled {
            guard let email = enterEmailTextField.text,
                let name = enterNameTextField.text else {return}
            enterEmailTextField.resignFirstResponder()
            enterNameTextField.resignFirstResponder()
            emailLabel.text = email
            nameLabel.text = name
            editButtonOutlet.setTitle("Edit", for: .normal)
            enterNameTextField.text = ""
            enterEmailTextField.text = ""
            emailLabel.isHidden = false
            nameLabel.isHidden = false
            enterEmailTextField.isHidden = true
            enterNameTextField.isHidden = true
        }
    }
}
