//
//  ProfileVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/16/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    
    var isTapped: Bool = false
    
    
    //MARK: - Properties
    var intoleranceSelected: String = ""
    var dietButtonTagNumber : Int = 7
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    //MARK: - Actions
    @IBAction func DietsButtonPressed(_ sender: UIButton) {
    
        
        switch sender.tag {
        case 0:
            RecipeFetchController.shared.diets = "vegan"

        case 1:
            RecipeFetchController.shared.diets = "paleo"

        case 2:
            RecipeFetchController.shared.diets = "primal"

        case 3:
            RecipeFetchController.shared.diets = "vegetarian"

        case 4:
            RecipeFetchController.shared.diets = "pescetarian"

        case 5:
            RecipeFetchController.shared.diets = "lacto vegetarian"

        default:
            RecipeFetchController.shared.diets = ""

        }
        
        
        if isTapped == false {
            sender.backgroundColor = .black
            sender.setTitleColor(.white, for: .normal)
            isTapped = true
        } else {
            sender.backgroundColor = .red
            sender.setTitleColor(.white, for: .normal)
            isTapped = false
        }
    }
    
    
    
    @IBAction func intolerancesAndAlergiesButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            RecipeFetchController.shared.intolerance = "dairy"
        case 1:
            RecipeFetchController.shared.intolerance = "peanut"
        case 2:
            RecipeFetchController.shared.intolerance = "soy"
        case 3:
            RecipeFetchController.shared.intolerance = "egg"
        case 4:
            RecipeFetchController.shared.intolerance = "seafood"
        case 5:
            RecipeFetchController.shared.intolerance = "sulfite"
        case 6:
            RecipeFetchController.shared.intolerance = "gluten"
        case 7:
            RecipeFetchController.shared.intolerance = "sesame"
        case 8:
            RecipeFetchController.shared.intolerance = "shellfish"
        default:
            RecipeFetchController.shared.intolerance = ""
        }
        if isTapped == false {
            sender.backgroundColor = .black
            sender.setTitleColor(.white, for: .normal)
            isTapped = true
        } else {
            sender.backgroundColor = .red
            sender.setTitleColor(.white, for: .normal)
            isTapped = false
        }
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        //save the settings - move the selected items to querry items for fetching
        
    }
    
    
}
