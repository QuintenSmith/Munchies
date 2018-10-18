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
    }
    
    
    //MARK: - Side Menu Method
    func sideMenu() {
        if revealViewController() != nil {
            menuBtn.target = revealViewController()
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.layoutIfNeeded()
        }
    }
    
    
    //MARK: - CollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RecipeFetchController.shared.filteredRecipies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCollectionViewCell else {return UICollectionViewCell()}
        let recipe = RecipeFetchController.shared.filteredRecipies[indexPath.row]
        RecipeFetchController.shared.fetchImage(at: recipe.image) { (image) in
            DispatchQueue.main.async {
                cell.cellData = recipe
                cell.thumbnail = image

            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = RecipeFetchController.shared.filteredRecipies[indexPath.row]
        let detailViewController = UIStoryboard.init(name: "Recipe", bundle: nil).instantiateViewController(withIdentifier: "recipeDetailView") as! RecipeVC
        
        let cell = searchResultColectionView.cellForItem(at: indexPath) as! SearchCollectionViewCell
        
        
        let image = cell.recipeImage.image
        detailViewController.recipeImage = image
        detailViewController.recipe = recipe
        
        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toRecipeDetailSegue" {
//
//            guard let destinationVC = segue.destination as? RecipeVC else { print("❌") ; return}
//          //  let recipe =
//            //need to add computed propertyy to the model so i can pass the whole recipe insted of recipe and image
//            guard let indexPath = searchResultColectionView.indexPathsForSelectedItems?.first else {
//                return
//            }
//        }
//    }
}
