//
//  MainTabBarController.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/12/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupViewControllers()
    }
    
    fileprivate func getViewControllerFromID(storyboardName: String, storyBoardIdentifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: storyBoardIdentifier)
    }
    

    func setupViewControllers() {
        let searchVC = getViewControllerFromID(storyboardName: "Search", storyBoardIdentifier: "searchStoryboardID")
        let pantryVC = getViewControllerFromID(storyboardName: "Pantry", storyBoardIdentifier: "pantryStoryboardID")
        let grocerieslistVC = getViewControllerFromID(storyboardName: "GroceriesList", storyBoardIdentifier: "groceriesListStoryBoardID")
        let favoritesVC = getViewControllerFromID(storyboardName: "Favorites", storyBoardIdentifier: "favoritesStoryBoardID")
        let journalVC = getViewControllerFromID(storyboardName: "Journal", storyBoardIdentifier: "journalStoryBoardID")
        
        let searchNavigationController = navigationControllerWith(rootViewController: searchVC, unselectedImage: #imageLiteral(resourceName: "Disabled-3"), selectedImage: #imageLiteral(resourceName: "Light-3"))
        let pantryNavigationController = navigationControllerWith(rootViewController: pantryVC, unselectedImage: #imageLiteral(resourceName: "Disabled-4"), selectedImage: #imageLiteral(resourceName: "Light-4"))
        let groceriesNavigationController = navigationControllerWith(rootViewController: grocerieslistVC, unselectedImage: #imageLiteral(resourceName: "Disabled-1"), selectedImage: #imageLiteral(resourceName: "Light-1"))
        let favoritesNavigationController = navigationControllerWith(rootViewController: favoritesVC, unselectedImage: #imageLiteral(resourceName: "Disabled-2"), selectedImage: #imageLiteral(resourceName: "Light-2"))
       let journalNavigationController = navigationControllerWith(rootViewController: journalVC, unselectedImage: #imageLiteral(resourceName: "Disabled-1"), selectedImage: #imageLiteral(resourceName: "Light"))
        
        tabBar.tintColor = .black
        viewControllers = [
            searchNavigationController,
            pantryNavigationController,
            groceriesNavigationController,
            favoritesNavigationController,
            journalNavigationController
        ]
        
        guard let items = tabBar.items else {return}
        items.forEach{ $0.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)}
    }
    
    fileprivate func navigationControllerWith(rootViewController: UIViewController?, unselectedImage: UIImage, selectedImage: UIImage) -> UINavigationController {
        var viewController: UIViewController
        if rootViewController == nil {
            viewController = UIViewController()
        } else {
            viewController = rootViewController!
        }
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.image = unselectedImage
        navigationController.tabBarItem.selectedImage = selectedImage
        return navigationController
    }
}
