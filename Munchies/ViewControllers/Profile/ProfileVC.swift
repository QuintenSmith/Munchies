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
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var clearButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var saveButtonOutlet: UIBarButtonItem!
    
    
    //MARK: - Diets Button Outlets
    @IBOutlet weak var veganDietOutlet: RoundedShapeButton!
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
    var saveButtonState = true
    var user: User?
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        clearButtonOutlet.isEnabled = false
        dietButtons = [veganDietOutlet, paleoDietOutlet, primalDietOutlet, vagetarianDietOutlet, pescetarianDietOutlet, lactoVegetarianDietOutlet]
        intoleranceButtons = [diaryFreeOutlet, peanutFreeOutlet, soyFreeOutlet, eggFreeOutlet, seafoodFreeOutlet, sulfiteFreeOutlet, glutenFreeOutlet, seasameFreeOutlet, shellfishFreeOutlet]
        buttonStates = [diaryFreeButton, peanutFreeButton, soyFreeButton, eggFreeButton, seafoodFreeButton, sulfiteFreeButton, glutenFreeButton, seasameFreeButton, shellfishFreeButton]
        sideMenu()
        nameTextField.delegate = self
        setupButtonsBasedOnPreviousSettings()
        guard let user = UserController.shared.loggedInUser else {return}
        nameTextField.text = user.name
         setupButtonsBasedOnPreviousSettings()
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
    
    
    
    //MARK: - Actions
    @IBAction func DietsButtonPressed(_ sender: UIButton) {
        guard let user = UserController.shared.loggedInUser else {return}
        guard var diet = user.diet else {return}
        dietButtons.forEach{
            $0.backgroundColor = AppStylingController.shared.buttonUnselectedColor
        }
        switch sender.tag {
        case 0:
            diet = "vegan"
            veganDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case 1:
            diet = "paleo"
            paleoDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case 2:
            diet = "primal"
            primalDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case 3:
            diet = "vegetarian"
            vagetarianDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case 4:
            diet = "pescetarian"
            pescetarianDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case 5:
            diet = "lacto vegetarian"
            lactoVegetarianDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        default:
            diet = ""
            
        }
        print(diet)
    }
    
    
    @IBAction func intolerancesAndAlergiesButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            adjustSettingsAndFlip(button: diaryFreeOutlet, intolerance: "dairy", buttonState: diaryFreeButton)
            diaryFreeButton = !diaryFreeButton
        case 1:
            adjustSettingsAndFlip(button: peanutFreeOutlet, intolerance: "peanut", buttonState: peanutFreeButton)
            peanutFreeButton = !peanutFreeButton
        case 2:
            adjustSettingsAndFlip(button: soyFreeOutlet, intolerance: "soy", buttonState: soyFreeButton)
            soyFreeButton = !soyFreeButton
        case 3:
            adjustSettingsAndFlip(button: eggFreeOutlet, intolerance: "egg", buttonState: eggFreeButton)
            eggFreeButton = !eggFreeButton
        case 4:
            adjustSettingsAndFlip(button: seafoodFreeOutlet, intolerance: "seafood", buttonState: seafoodFreeButton)
            seafoodFreeButton = !seafoodFreeButton
        case 5:
            adjustSettingsAndFlip(button: sulfiteFreeOutlet, intolerance: "sulfite", buttonState: sulfiteFreeButton)
            sulfiteFreeButton = !sulfiteFreeButton
        case 6:
            adjustSettingsAndFlip(button: glutenFreeOutlet, intolerance: "gluten", buttonState: glutenFreeButton)
            glutenFreeButton = !glutenFreeButton
        case 7:
            adjustSettingsAndFlip(button: seasameFreeOutlet, intolerance: "sesame", buttonState: seasameFreeButton)
            seasameFreeButton = !seasameFreeButton
        case 8:
            adjustSettingsAndFlip(button: shellfishFreeOutlet, intolerance: "shellfish", buttonState: shellfishFreeButton)
            shellfishFreeButton = !shellfishFreeButton
        default:
            print("unknown alergy")
        }

        
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if saveButtonState == true {
            editView.isHidden = true
            clearButtonOutlet.isEnabled = true
            saveButtonState = false
            saveButtonOutlet.image = #imageLiteral(resourceName: "header-5")
        } else {
            editView.isHidden = false
            clearButtonOutlet.isEnabled = false
            saveButtonState = true
            saveButtonOutlet.image = #imageLiteral(resourceName: "header-2")
            showSuccesfullAlert()
        }
    }
    
    //clear all settings
    @IBAction func clearButtonPressed(_ sender: Any) {
        //change the buttons to unselected state
        dietButtons.forEach{
            $0.backgroundColor = AppStylingController.shared.buttonUnselectedColor
        }
        //remove diets from query items
        RecipeFetchController.shared.diet = ""
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
        //remove intolerances form (set) and therefore from query items
        RecipeFetchController.shared.intolerances.removeAll()
    }
    
    
    //MARK: - Helper Methods
    //Sets up the buttons based on users save settings on viewDidLoad
    func setupButtonsBasedOnPreviousSettings(){
        guard let user = UserController.shared.loggedInUser else {return}
        switch user.diet {
        case "vegan":
            veganDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case "paleo":
            paleoDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case "primal":
            primalDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case "vegetarian":
           vagetarianDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case "pescetarian":
            pescetarianDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case "lacto vegetarian":
            lactoVegetarianDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        default :
            print("no diet")
        }
        guard let intolerances = user.intolerances else {
            print("no intolerances")
            return}
        print("\(intolerances)")
        if intolerances.contains("dairy"){
            diaryFreeOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
            diaryFreeButton = true
        }
        if intolerances.contains("peanut"){
            peanutFreeOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
            peanutFreeButton = true
        }
        if intolerances.contains("soy"){
            soyFreeOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
            soyFreeButton = true
        }
        if intolerances.contains("egg"){
            eggFreeOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
            eggFreeButton = true
        }
        if intolerances.contains("seafood"){
            seafoodFreeOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
            seafoodFreeButton = true
        }
        if intolerances.contains("sulfite"){
            sulfiteFreeOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
            sulfiteFreeButton = true
        }
        if intolerances.contains("gluten"){
            glutenFreeOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
            glutenFreeButton = true
        }
        if intolerances.contains("sesame"){
            seasameFreeOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
            seasameFreeButton = true
        }
        if intolerances.contains("shellfish"){
            shellfishFreeOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
            shellfishFreeButton = true
        }
        
    }
    
    
    //Flips the state of the button - and adjust coresponding settings
    func adjustSettingsAndFlip(button: UIButton, intolerance: String, buttonState: Bool){
        guard let user = UserController.shared.loggedInUser else {return}
        guard var intolerances = user.intolerances else {return}
        if buttonState == false {
            intolerances.insert(intolerance)
            button.backgroundColor = AppStylingController.shared.buttonSelectedColor
        } else if buttonState == true {
            intolerances.remove(intolerance)
            button.backgroundColor = AppStylingController.shared.buttonUnselectedColor
        }
    }
    
    //Return Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    func showSuccesfullAlert(){
        let alert = UIAlertController(title: "Profile Saved", message: "Great job, your profile is now updated.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
