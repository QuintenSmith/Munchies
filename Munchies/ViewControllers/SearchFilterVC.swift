//
//  SearchFilterVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/17/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class SearchFilterVC: UIViewController {
    
    //MARK: - Properties
    var curentTagButtonTime: Int = 60
    var portionSize: Int = 2
    
    //This is temporary ingredient list - its gone have to be moved to model controller for proper MVC
    var ingredientListFromCamera = [String]()
    
    
    //MARK: - Outlets
    @IBOutlet weak var ingredientTableView: UITableView!
    
    
    
    //MARK: - LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK: - Actions
    @IBAction func timeButtonTapped(_ sender: UIButton) {
        

        switch sender.tag {
        case 0:
            curentTagButtonTime = 15
            print(curentTagButtonTime)
        case 1:
            curentTagButtonTime = 30
            print(curentTagButtonTime)
        case 2:
            curentTagButtonTime = 60
            print(curentTagButtonTime)
        case 3:
            curentTagButtonTime = 90
            print(curentTagButtonTime)
        case 4:
            curentTagButtonTime = 400
            print(curentTagButtonTime)
        default:
            curentTagButtonTime = 60
            print(curentTagButtonTime)
            
        }
    }
    
    
    @IBAction func portionButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            portionSize = 1
        case 1:
            portionSize = 2
        case 2:
            portionSize = 4
        case 3:
            portionSize = 6
        case 4:
            portionSize = 8
        case 5:
            portionSize = 10
        default:
            portionSize = 2
        }
    }
    
    @IBAction func findButtonTapped(_ sender: Any) {
        
        //display random food joke
        
        //run fetch functions
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        RecipeFetchController.shared.searchRecipiesBy(ingredients: convertIngredientArrayToString()) { (recipes) in
            print("✅Finished fetching recipies")
            guard let recipes = recipes else {return}
            RecipeFetchController.shared.recipes = recipes
            
            var arrayOfRecipeIds = [Int]()
            for recipe in RecipeFetchController.shared.recipes {
                arrayOfRecipeIds.append(recipe.id)
            }
            
            RecipeFetchController.shared.fetchDetailedRecipies(ids: arrayOfRecipeIds, completion: { (detailedRecipies) in
                guard let detailedRecipies = detailedRecipies else {return}
                RecipeFetchController.shared.recipiesWithDetail = detailedRecipies
                print("✅Finished fetching detailed recipies")
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            })
        }
    }
    
    
    //MARK: - Helper Method to convert array into string
    func convertIngredientArrayToString() -> String{
       return ingredientListFromCamera.joined(separator: ", ")
    }
    
    
    

}
