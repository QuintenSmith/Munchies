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
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        if RecipeFetchController.shared.favoriteRecipies.count >= 1 {
          self.favoritesCollectionView.isHidden = false
        } else {
          self.favoritesCollectionView.isHidden = true
        }
        sideMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    
    //MARK: - Actions
    //TODO: - need to feed in the data for collection views based on which button was pressed
    @IBAction func wishListButtonPressed(_ sender: Any) {
        
    }
    
    
    @IBAction func favoritesButtonPressed(_ sender: Any) {
        
    }
    
    
    @IBAction func sharedItemsButtonPressed(_ sender: Any) {
   
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        #warning ("pick what you want to share here")
        let image = UIImage(named: "pasta5")
        let shareSheet = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(shareSheet, animated: true, completion: nil)
    }
}
