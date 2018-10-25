//
//  SearchVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    //MARK: - Outlets
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet var searchResultColectionView: UICollectionView!
    
    
    //MARK: - LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchResultColectionView.delegate = self
        self.searchResultColectionView.dataSource = self
        searchResultColectionView.reloadData()
        sideMenu()
        UINavigationBar.appearance().barTintColor = UIColor(red: 235/255, green: 111/255, blue: 100/255, alpha: 1)
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white 
        let titleLabel = UILabel()
        titleLabel.text = "Results"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: "Results", size: 12)
        self.navigationItem.titleView = titleLabel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchResultColectionView.reloadData()
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
    
    
    //MARK: - CollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("🚀\(RecipeFetchController.shared.filteredRecipiesWithDetailAndImage.count)")
        return RecipeFetchController.shared.filteredRecipiesWithDetailAndImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCollectionViewCell else {return UICollectionViewCell()}
        let recipe = RecipeFetchController.shared.filteredRecipiesWithDetailAndImage[indexPath.row]
        print("🚀\(recipe.detailedRecipe.title)")
        cell.cellData = recipe
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = RecipeFetchController.shared.filteredRecipiesWithDetailAndImage[indexPath.row]
        //this will set the instructions in the InstructionsTableViewController
        RecipeFetchController.shared.temporaryInstructionStorage = recipe.detailedRecipe.analyzedInstructions
        let storyboard = UIStoryboard(name: "Recipe", bundle: nil)
        guard let recipeVC = storyboard.instantiateViewController(withIdentifier: "recipeDetailView") as? RecipeVC else {return}
        recipeVC.recipeToDispaly = recipe
        let navigationController = UINavigationController(rootViewController: recipeVC)
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Actions
    @IBAction func backButtonPressed(_ sender: Any) {
        RecipeFetchController.shared.filteredRecipies.removeAll()
        RecipeFetchController.shared.recipiesWithDetail.removeAll()
        RecipeFetchController.shared.recipes.removeAll()
        RecipeFetchController.shared.filteredRecipiesWithDetailAndImage.removeAll()
        self.dismiss(animated: true)
    }
    
}
