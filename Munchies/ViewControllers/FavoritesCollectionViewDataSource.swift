//
//  FavoritesCollectionViewDataSource.swift
//  Munchies
//
//  Created by Quinten Smith on 10/17/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class FavoritesCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var numberOfItems: Int
    var recepies: [Recipe]
    
    init(numberOfItems: Int, recepies: [Recipe]){
        self.numberOfItems = numberOfItems
        self.recepies = recepies
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritesCell", for: indexPath) as? FavoritesCollectionViewCell
        let recepie = recepies[indexPath.row]
        cell?.cellData = recepie
        return cell ?? UICollectionViewCell()
    }
}
