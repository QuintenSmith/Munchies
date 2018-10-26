//
//  FavoritesVC.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    //MARK: - Outlets
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    
    //MARK: - Properties
    var recIds : [Int] = []
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        
        guard let user = UserController.shared.loggedInUser else {return}
        guard let favorites = user.favorites else {return}
        
        for recipeid in favorites {
            recIds.append(recipeid.recipeID)
        }
        
        FavoriteController.shared.fetchFavorites(user: user) { (success) in
            if success {
                RecipeFetchController.shared.fetchDetailedRecipies(ids: self.recIds, completion: { (detailedRecipes) in
                    guard let detailedRecipes = detailedRecipes else {return}
                    let dispatchGroup = DispatchGroup()
                    for recipe in detailedRecipes {
                        //MARK: - Fetch Images Call
                        if let image = recipe.image {
                            dispatchGroup.enter()
                            RecipeFetchController.shared.fetchImage(at: image) { (image) in
                                let detailedRecipe = RecipeWithDetailAndImage.init(detailedRecipe: recipe, picture: image)
                                if !RecipeFetchController.shared.favoriteRecipies.contains(detailedRecipe){
                                    RecipeFetchController.shared.favoriteRecipies.append(detailedRecipe)
                                }
                                print("🚀 image fetched and apended")
                                dispatchGroup.leave()
                            }
                        }
                        print("finished fetching images")
                    }
                    //onec its done with all the fetchin in dispatch group, it calls the complepiton
                    dispatchGroup.notify(queue: .main) {
                        print("Calling Completion Now")
                        //                        completion(true)
                    }
                })
            }
        }
        
        if RecipeFetchController.shared.favoriteRecipies.count >= 1 {
            self.favoritesCollectionView.isHidden = false
        } else {
            self.favoritesCollectionView.isHidden = true
        }
        sideMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        guard let user = UserController.shared.loggedInUser else {return}
        //        guard let favorites = user.favorites else {return}
        //        for recipeid in favorites {
        //            recIds.append(recipeid.recipeID)
        //        }
        //
        
        super.viewWillAppear(animated)
        
        //        FavoriteController.shared.fetchFavorites(user: user) { (success) in
        //            if success {
        //                RecipeFetchController.shared.fetchDetailedRecipies(ids: self.recIds, completion: { (detailedRecipes) in
        //                    guard let detailedRecipes = detailedRecipes else {return}
        //                    let dispatchGroup = DispatchGroup()
        //                    for recipe in detailedRecipes {
        //                        //MARK: - Fetch Images Call
        //                        if let image = recipe.image {
        //                            dispatchGroup.enter()
        //                            RecipeFetchController.shared.fetchImage(at: image) { (image) in
        //                                let detailedRecipe = RecipeWithDetailAndImage.init(detailedRecipe: recipe, picture: image)
        //                               RecipeFetchController.shared.favoriteRecipies.append(detailedRecipe)
        //                                print("🚀 image fetched and apended")
        //                                dispatchGroup.leave()
        //                            }
        //                        }
        //                        print("finished fetching images")
        //                    }
        //                    //onec its done with all the fetchin in dispatch group, it calls the complepiton
        //                    dispatchGroup.notify(queue: .main) {
        //                        print("Calling Completion Now")
        ////                        completion(true)
        //                    }
        //                })
        //            }
        //        }
        favoritesCollectionView.reloadData()
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
    
    
    //MARK: - Colection View Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RecipeFetchController.shared.favoriteRecipies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as? FavoritesCollectionViewCell else {return UICollectionViewCell()}
        let recipe = RecipeFetchController.shared.favoriteRecipies[indexPath.row]
        cell.cellData = recipe
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = RecipeFetchController.shared.favoriteRecipies[indexPath.row]
        //this will set the instructions in the InstructionsTableViewController
        RecipeFetchController.shared.temporaryInstructionStorage = recipe.detailedRecipe.analyzedInstructions
        
        let storyboard = UIStoryboard(name: "Recipe", bundle: nil)
        guard let recipeVC = storyboard.instantiateViewController(withIdentifier: "recipeDetailView") as? RecipeVC else {return}
        recipeVC.recipeToDispaly = recipe
        let navigationController = UINavigationController(rootViewController: recipeVC)
        self.present(navigationController, animated: true, completion: nil)
    }
    
}
