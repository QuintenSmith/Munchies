//
//  PreferencesVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/16/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class PreferencesVC: UIViewController {
    
    var name: String?
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        dietButtons = [veganDietOutlet, paleoDietOutlet, primalDietOutlet, vagetarianDietOutlet, pescetarianDietOutlet, lactoVegetarianDietOutlet]
        
        intoleranceButtons = [diaryFreeOutlet, peanutFreeOutlet, soyFreeOutlet, eggFreeOutlet, seafoodFreeOutlet, sulfiteFreeOutlet, glutenFreeOutlet, seasameFreeOutlet, shellfishFreeOutlet]
        
        buttonStates = [diaryFreeButton, peanutFreeButton, soyFreeButton, eggFreeButton, seafoodFreeButton, sulfiteFreeButton, glutenFreeButton, seasameFreeButton, shellfishFreeButton]
        
    }
    
    //MARK: - Actions
    @IBAction func DietsButtonPressed(_ sender: UIButton) {
        
        dietButtons.forEach{
            $0.backgroundColor = AppStylingController.shared.buttonUnselectedColor
        }
        
        switch sender.tag {
        case 0:
            RecipeFetchController.shared.diet = "vegan"
            veganDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case 1:
            RecipeFetchController.shared.diet = "paleo"
            paleoDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case 2:
            RecipeFetchController.shared.diet = "primal"
            primalDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case 3:
            RecipeFetchController.shared.diet = "vegetarian"
            vagetarianDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case 4:
            RecipeFetchController.shared.diet = "pescetarian"
            pescetarianDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        case 5:
            RecipeFetchController.shared.diet = "lacto vegetarian"
            lactoVegetarianDietOutlet.backgroundColor = AppStylingController.shared.buttonSelectedColor
        default:
            RecipeFetchController.shared.diet = ""
            
        }
        print(RecipeFetchController.shared.diet)
    }
    
    @IBAction func intolerancesAndAlergiesButtonPressed(_ sender: UIButton) {
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
    
    func adjustSettingsAndFlip(button: UIButton, intolerance: String, buttonState: Bool){
        if buttonState == false {
            RecipeFetchController.shared.intolerances.insert(intolerance)
            button.backgroundColor = AppStylingController.shared.buttonSelectedColor
        } else if buttonState == true {
            RecipeFetchController.shared.intolerances.remove(intolerance)
            button.backgroundColor = AppStylingController.shared.buttonUnselectedColor
        }
    }
    
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        
        guard let name = self.name else {return}
        let diet = RecipeFetchController.shared.diet
        let intolerances = RecipeFetchController.shared.intolerances
        
        UserController.shared.createUserWith(name: name, diet: diet, intolerances: intolerances) { (success) in
            if success {
                guard let user = UserController.shared.loggedInUser else {return}
                print(user.name, user.appleUserReference)
            } else {
                return 
            }
        }
        
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil) 
    }
    
    
}
