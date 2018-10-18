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
    var recipies: [Recipe] = {
       
        let recipe1 = Recipe(picture: UIImage(named: "burger0")!, recipeTitle: "Burger", rating: 3)
        let recipe2 = Recipe(picture: UIImage(named: "pasta6")!, recipeTitle: "Pasta", rating: 5)
        let recipe3 = Recipe(picture: UIImage(named: "pizza1")!, recipeTitle: "Pizza", rating: 4)
        let recipe4 = Recipe(picture: UIImage(named: "salad2")!, recipeTitle: "Salad", rating: 3)
        let recipe5 = Recipe(picture: UIImage(named: "sandwich1")!, recipeTitle: "Sandwich", rating: 4)
        let recipe6 = Recipe(picture: UIImage(named: "burger2")!, recipeTitle: "Burger", rating: 1)
        let recipe7 = Recipe(picture: UIImage(named: "pizza3")!, recipeTitle: "Pizza", rating: 4)
        let recipe8 = Recipe(picture: UIImage(named: "salad6")!, recipeTitle: "Salad", rating: 2)
        var someMockRecipe : [Recipe] = [recipe1, recipe2, recipe3, recipe4, recipe5, recipe6, recipe7, recipe8]
        
        return someMockRecipe
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        
        sideMenu()
    }
    
    func sideMenu() {
        if revealViewController() != nil {
            
            menuBtn.target = revealViewController()
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.layoutIfNeeded()
        }
    }
    
    //MARK: - Colection View Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return recipies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as? FavoritesCollectionViewCell else {return UICollectionViewCell()}
        let recipe = recipies[indexPath.row]
        cell.cellData = recipe
        return cell
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
        let image = UIImage(named: "pasta5")
        let shareSheet = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(shareSheet, animated: true, completion: nil)
    }
    
    
    
    
}
