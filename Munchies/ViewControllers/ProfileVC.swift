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
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var clearButtonOutlet: UIBarButtonItem!
    
    //MARK: - Diets Button Outlets
    @IBOutlet weak var veganDietButton: RoundedShapeButton!
    @IBOutlet weak var paleoDietOutlet: RoundedShapeButton!
    @IBOutlet weak var primalDietOutlet: RoundedShapeButton!
    @IBOutlet weak var vagetarianDietOutlet: RoundedShapeButton!
    @IBOutlet weak var pescetarianDietOutlet: RoundedShapeButton!
    @IBOutlet weak var lactoVegetarianDietOutlet: RoundedShapeButton!
    
    //MARK: - Intolerances Outlets
    @IBOutlet weak var diaryFreeOutlet: RoundedShapeButton!
    @IBOutlet weak var peanutFreeOutlet: RoundedShapeButton!
    @IBOutlet weak var soyFreeOutlet: RoundedShapeButton!
    @IBOutlet weak var eggFreeOutlet: RoundedShapeButton!
    @IBOutlet weak var seafoodFreeOutlet: RoundedShapeButton!
    @IBOutlet weak var sulfiteFreeOutlet: RoundedShapeButton!
    @IBOutlet weak var glutenFreeOutlet: RoundedShapeButton!
    @IBOutlet weak var seasameFreeOutlet: RoundedShapeButton!
    @IBOutlet weak var shellfishFreeOutlet: RoundedShapeButton!
    
    //MARK: - Buttons State
    var diaryFreeButton : Bool = false
    var peanutFreeButton : Bool = false
    var soyFreeButton : Bool = false
    var eggFreeButton : Bool = false
    var seafoodFreeButton : Bool = false
    var sulfiteFreeButton : Bool = false
    var glutenFreeButton : Bool = false
    var seasameFreeButton : Bool = false
    var shellfishFreeButton : Bool = false
    
    //MARK: - Properties
    var dietButtons = [UIButton]()
    var intoleranceButtons = [UIButton]()
    var buttonStates = [Bool]()
    var intoleranceSelected: String = ""
    var dietButtonTagNumber : Int = 7
    var isTapped: Bool = true
    
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        clearButtonOutlet.isEnabled = false
        dietButtons = [veganDietButton, paleoDietOutlet, primalDietOutlet, vagetarianDietOutlet, pescetarianDietOutlet, lactoVegetarianDietOutlet]
        intoleranceButtons = [diaryFreeOutlet, peanutFreeOutlet, soyFreeOutlet, eggFreeOutlet, seafoodFreeOutlet, sulfiteFreeOutlet, glutenFreeOutlet, seasameFreeOutlet, shellfishFreeOutlet]
        buttonStates = [diaryFreeButton, peanutFreeButton, soyFreeButton, eggFreeButton, seafoodFreeButton, sulfiteFreeButton, glutenFreeButton, seasameFreeButton, shellfishFreeButton]
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
    
    func adjustSettingsAndFlip(button: UIButton, intolerance: String, buttonState: Bool){
        if buttonState == false {
            RecipeFetchController.shared.intolerances.insert(intolerance)
            button.backgroundColor = AppStylingController.shared.buttonSelectedColor
           // buttonState = true
        } else if buttonState == true {
            RecipeFetchController.shared.intolerances.remove(intolerance)
            button.backgroundColor = AppStylingController.shared.buttonUnselectedColor
            //buttonState = false
        }
    }
    
    
    @IBAction func intolerancesAndAlergiesButtonPressed(_ sender: UIButton) {
        //  isTapped = true
        
        #warning ("the idea is good but i think the colors are not matching therefore itsn not working")
        
        
        switch sender.tag {
        case 0:
           // RecipeFetchController.shared.intolerance = "dairy"
            adjustSettingsAndFlip(button: diaryFreeOutlet, intolerance: "dairy", buttonState: diaryFreeButton)
            diaryFreeButton = !diaryFreeButton
        case 1:
           // RecipeFetchController.shared.intolerance = "peanut"
            adjustSettingsAndFlip(button: peanutFreeOutlet, intolerance: "peanut", buttonState: peanutFreeButton)
            peanutFreeButton = !peanutFreeButton
        case 2:
           // RecipeFetchController.shared.intolerance = "soy"
            adjustSettingsAndFlip(button: soyFreeOutlet, intolerance: "soy", buttonState: soyFreeButton)
            soyFreeButton = !soyFreeButton
        case 3:
           // RecipeFetchController.shared.intolerance = "egg"
            adjustSettingsAndFlip(button: eggFreeOutlet, intolerance: "egg", buttonState: eggFreeButton)
            eggFreeButton = !eggFreeButton
        case 4:
           // RecipeFetchController.shared.intolerance = "seafood"
            adjustSettingsAndFlip(button: seafoodFreeOutlet, intolerance: "seafood", buttonState: seafoodFreeButton)
            seafoodFreeButton = !seafoodFreeButton
        case 5:
           // RecipeFetchController.shared.intolerance = "sulfite"
            adjustSettingsAndFlip(button: sulfiteFreeOutlet, intolerance: "sulfite", buttonState: sulfiteFreeButton)
            sulfiteFreeButton = !sulfiteFreeButton
        case 6:
           // RecipeFetchController.shared.intolerance = "gluten"
            adjustSettingsAndFlip(button: glutenFreeOutlet, intolerance: "gluten", buttonState: glutenFreeButton)
            glutenFreeButton = !glutenFreeButton
        case 7:
           // RecipeFetchController.shared.intolerance = "sesame"
            adjustSettingsAndFlip(button: seasameFreeOutlet, intolerance: "sesame", buttonState: seasameFreeButton)
            seasameFreeButton = !seasameFreeButton
        case 8:
          //  RecipeFetchController.shared.intolerance = "shellfish"
            adjustSettingsAndFlip(button: shellfishFreeOutlet, intolerance: "shellfish", buttonState: shellfishFreeButton)
            shellfishFreeButton = !shellfishFreeButton
        default:
           // RecipeFetchController.shared.intolerance = ""
            print("🔔🔔\(RecipeFetchController.shared.intolerances)")
        }
        print("🔔🔔\(RecipeFetchController.shared.intolerances)")
        
    }
    var saveButtonState = true
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        //save the settings - move the selected items to querry items for fetching
       // saveButtonState = true
        if saveButtonState == true {
            editView.isHidden = true
            clearButtonOutlet.isEnabled = true
            saveButtonState = false
        } else {
            editView.isHidden = false
            clearButtonOutlet.isEnabled = false
            saveButtonState = true
        }
        
        
        //save changes - pretymuch just the name
        // the diets and intolerances save on their own i think
        
        
        
        
        
    }
    //clear all settings
    @IBAction func clearButtonPressed(_ sender: Any) {
        
        //change the buttons to unselected state
        dietButtons.forEach{
            $0.backgroundColor = AppStylingController.shared.buttonUnselectedColor
        }
        //remove diets from query items
        RecipeFetchController.shared.diets = ""
        //change intolerance buttons to unselected state
        diaryFreeButton = false
        peanutFreeButton = false
        soyFreeButton = false
        eggFreeButton = false
        seafoodFreeButton = false
        sulfiteFreeButton = false
        glutenFreeButton = false
        seasameFreeButton = false
        shellfishFreeButton = false
        
        intoleranceButtons.forEach{$0.backgroundColor = AppStylingController.shared.buttonUnselectedColor}
        
        //remove intolerances form (array) and therefore from query items
        RecipeFetchController.shared.intolerances.removeAll()
        
    }
    
    
    
}
