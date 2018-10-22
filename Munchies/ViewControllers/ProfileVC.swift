//
//  ProfileVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/16/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITextFieldDelegate {

    //MARK: - Outlets
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    
    //MARK: - Diets Button Outlets
    @IBOutlet weak var veganDietButton: RoundedShapeButton!
    @IBOutlet weak var paleoDietOutlet: RoundedShapeButton!
    @IBOutlet weak var primalDietOutlet: RoundedShapeButton!
    @IBOutlet weak var vagetarianDietOutlet: RoundedShapeButton!
    @IBOutlet weak var pescetarianDietOutlet: RoundedShapeButton!
    @IBOutlet weak var lactoVegetarianDietOutlet: RoundedShapeButton!
    
    
    //MARK: - Properties
    var dietButtons = [UIButton]()
    var intoleranceSelected: String = ""
    var dietButtonTagNumber : Int = 7
    var isTapped: Bool = false
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        dietButtons = [veganDietButton, paleoDietOutlet, primalDietOutlet, vagetarianDietOutlet, pescetarianDietOutlet, lactoVegetarianDietOutlet]
      sideMenu()
        nameTextField.delegate = self
    }
    
    
    //MARK: - Side Menu Method
    func sideMenu() {
        if revealViewController() != nil {
            menuBtn.target = revealViewController()
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 325
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    
    //MARK: - Actions
    @IBAction func DietsButtonPressed(_ sender: UIButton) {
    
        dietButtons.forEach{
            $0.backgroundColor = AppStylingController.shared.buttonUnselectedColor
        }
        
        switch sender.tag {
        case 0:
            RecipeFetchController.shared.diets = "vegan"
            veganDietButton.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case 1:
            RecipeFetchController.shared.diets = "paleo"
            paleoDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case 2:
            RecipeFetchController.shared.diets = "primal"
            primalDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case 3:
            RecipeFetchController.shared.diets = "vegetarian"
            vagetarianDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case 4:
            RecipeFetchController.shared.diets = "pescetarian"
            pescetarianDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case 5:
            RecipeFetchController.shared.diets = "lacto vegetarian"
            lactoVegetarianDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        default:
            RecipeFetchController.shared.diets = ""

        }
        print(RecipeFetchController.shared.diets)
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
            sender.backgroundColor = AppStylingController.shared.buttonUnselectedColor
            //sender.setTitleColor(.white, for: .normal)
            isTapped = true
        } else {
            sender.backgroundColor = AppStylingController.shared.buttonSelectedColor
           // sender.setTitleColor(.white, for: .normal)
            isTapped = false
        }
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        //save the settings - move the selected items to querry items for fetching
        
    }
    
    
}
