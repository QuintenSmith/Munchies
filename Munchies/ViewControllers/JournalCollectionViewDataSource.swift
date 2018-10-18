//
//  FavoritesCollectionViewDataSource.swift
//  Munchies
//
//  Created by Quinten Smith on 10/17/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class JournalCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var numberOfItems: Int
    var recipes: [Recipe]
    
    init(numberOfItems: Int, recipes: [Recipe]){
        self.numberOfItems = numberOfItems
        self.recipes = recipes
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JournalCell", for: indexPath) as? JournalDashboardCollectionViewCell
        let recipe = recipes[indexPath.row]
        cell?.recipe = recipe
        return cell ?? UICollectionViewCell()
    }
}
