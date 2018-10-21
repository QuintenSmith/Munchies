//
//  SearchFilterVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/17/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit


class SearchFilterVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
 
    @IBOutlet weak var tableView: searchFilterSizedTableView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    //MARK: - Time To Cook Buttons Outlets
    @IBOutlet weak var thirdyMinuteButton: RoundedShapeButton!
    @IBOutlet weak var oneHourButton: RoundedShapeButton!
    @IBOutlet weak var hourAndAHalfButton: RoundedShapeButton!
    @IBOutlet weak var twoHourButton: RoundedShapeButton!
    @IBOutlet weak var twoHourPlusButton: RoundedShapeButton!
    
    //MARK: - Portion Size Buttons Outlets
    @IBOutlet weak var portionOneButton: RoundedShapeButton!
    @IBOutlet weak var portionTwoButton: RoundedShapeButton!
    @IBOutlet weak var portionFourButton: RoundedShapeButton!
    @IBOutlet weak var portionSixButton: RoundedShapeButton!
    @IBOutlet weak var portionEightButton: RoundedShapeButton!
    @IBOutlet weak var portionTenButton: RoundedShapeButton!
    
    
    //MARK: - Properties
    var timeToCookButtons = [UIButton]()
    var portionButtons = [UIButton]()
    var count: Int = 0
    var curentTagButtonTime: Int = 60
    var portionSize: Int = 2
    let buttonUnselectedColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.4)
    let buttonSelectedColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 1.0)

    //This is temporary ingredient list - its gone have to be moved to model controller for proper MVC
    var ingredientListFromCamera = [String]()
    
    
    //MARK: - LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        sideMenu()
        timeToCookButtons = [thirdyMinuteButton, oneHourButton, hourAndAHalfButton, twoHourButton, twoHourPlusButton]
        portionButtons = [portionOneButton, portionTwoButton, portionFourButton, portionSixButton, portionEightButton, portionTenButton]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if ImageClasificationController.shared.clasifications.count >= 1 {
            
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: ImageClasificationController.shared.clasifications.count - 1 , section: 0), at: .bottom, animated: true)
        }
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
    
    
    //MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImageClasificationController.shared.clasifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? SearchFilterIngredientTableViewCell
        cell?.ingredientCell.text = "\(ImageClasificationController.shared.clasifications[indexPath.row])"//"O  Ingredient \(indexPath.row+1)"
        return cell ?? UITableViewCell()
    }
    
//    //MARK: - Actions
    @IBAction func timeButtonTapped(_ sender: UIButton) {

        timeToCookButtons.forEach{
         $0.backgroundColor = buttonUnselectedColor
        }
        
        switch sender.tag {
        case 0:
            curentTagButtonTime = 15
            thirdyMinuteButton.backgroundColor = buttonSelectedColor
        case 1:
            curentTagButtonTime = 30
            oneHourButton.backgroundColor = buttonSelectedColor
        case 2:
            curentTagButtonTime = 60
            hourAndAHalfButton.backgroundColor = buttonSelectedColor
        case 3:
            curentTagButtonTime = 90
            twoHourButton.backgroundColor = buttonSelectedColor
        case 4:
            curentTagButtonTime = 400
            twoHourPlusButton.backgroundColor = buttonSelectedColor
        default:
            curentTagButtonTime = 60
        }
    }
    

    
    
    @IBAction func portionButtonTapped(_ sender: UIButton) {
        portionButtons.forEach{
             $0.backgroundColor = buttonUnselectedColor
        }
        
        switch sender.tag {
        case 0:
            portionSize = 1
            portionOneButton.backgroundColor = buttonSelectedColor
        case 1:
            portionSize = 2
            portionTwoButton.backgroundColor = buttonSelectedColor
        case 2:
            portionSize = 4
            portionFourButton.backgroundColor = buttonSelectedColor
        case 3:
            portionSize = 6
            portionSixButton.backgroundColor = buttonSelectedColor
        case 4:
            portionSize = 8
            portionEightButton.backgroundColor = buttonSelectedColor
        case 5:
            portionSize = 10
            portionTenButton.backgroundColor = buttonSelectedColor
        default:
            portionSize = 2
        }
    }
    
    @IBAction func findButtonTapped(_ sender: Any) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        //display random food joke
        //        print("🤩fetching joke")
        //        RecipeFetchController.shared.fetchRandomJoke { (success) in
        //            if success {
        //                let alert = UIAlertController(title: "Loading Results", message: RecipeFetchController.shared.randomJoke, preferredStyle: .alert)
        //                alert.addAction(UIAlertAction(title: "Haha", style: .cancel, handler: nil))
        //                print("😂presenting joke")
        //                self.present(alert, animated: true)
        //            }
        //        }
        
        print("🤩fetching recipes")
        
        //run fetch functions
        RecipeFetchController.shared.searchRecipiesBy(ingredients: ImageClasificationController.shared.clasificationsAsString()) { (recipes) in
            print("✅ Finished fetching recipies")
            guard let recipes = recipes else {return}
            RecipeFetchController.shared.recipes = recipes
            
            var arrayOfRecipeIds = [Int]()
            for recipe in RecipeFetchController.shared.recipes {
                arrayOfRecipeIds.append(recipe.id)
            }
            
            print("🤩 fetching detailed recipies")
            RecipeFetchController.shared.fetchDetailedRecipies(ids: arrayOfRecipeIds, completion: { (detailedRecipies) in
                guard let detailedRecipies = detailedRecipies else {return}
                RecipeFetchController.shared.recipiesWithDetail = detailedRecipies
                print("✅ Finished fetching detailed recipies")
                
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.updateTableViewAfterTimeFilter()
                    print("😋😋 about to present SearchResultVc - searchVC, Filtered Recipies count: \(RecipeFetchController.shared.filteredRecipies.count)")
                    
                    let storyboard = UIStoryboard(name: "Search", bundle: nil)
                    let searchVC = storyboard.instantiateViewController(withIdentifier: "searchStoryboardID")
                    let navigationController = UINavigationController(rootViewController: searchVC)
                    self.present(navigationController, animated: true, completion: nil)
                }
            })
        }
    }
    
    
    //MARK: - Helper Method to convert array into string
    func convertIngredientArrayToString() -> String{
        return ingredientListFromCamera.joined(separator: ", ")
    }
    
    
    //MARK: - helper function to filter by time it takes to cook diner
    func updateTableViewAfterTimeFilter(){
        RecipeFetchController.shared.filterRecipiesByTimeItTakesToMakeIt(arrayOfRecipies: RecipeFetchController.shared.recipiesWithDetail, timeItShouldTake: curentTagButtonTime, servingAmount: portionSize)
        print("🔥🔥 Portion size: \(portionSize), time: \(curentTagButtonTime)")
    }
    
    
    
    //MARK: - Present Camera Method
    func presentCamera(sourceType: UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        
        ImageClasificationController.shared.curentImageAndClasification = image
        
        let storyboard = UIStoryboard(name: "ImageClasification", bundle: nil)
        let recipeVC = storyboard.instantiateViewController(withIdentifier: "ImageClasification")
        //let navigationController = UINavigationController(rootViewController: recipeVC)
        self.present(recipeVC, animated: true, completion: nil)
    }
    
    

    //MARK: - Actions
 
    @IBAction func resetButtonPressed(_ sender: Any) {
        ImageClasificationController.shared.clasifications.removeAll()
        tableView.reloadData()
      
        
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        if  UIImagePickerController.isSourceTypeAvailable(.camera) {
            presentCamera(sourceType: .camera)
        }
    }
    
    
    
    
}

