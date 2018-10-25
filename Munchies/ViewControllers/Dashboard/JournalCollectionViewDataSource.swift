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
    var entry: [Entry]?
    var user: User? = UserController.shared.loggedInUser
    
    init(numberOfItems: Int, entries: [Entry]){
        self.numberOfItems = numberOfItems
        self.entry = entries
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let user = user else {return 0}
        guard let journalEntries = user.journalEntries else {return 0}
        if journalEntries.count > 6 {
        return numberOfItems
        } else {
            return journalEntries.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JournalCell", for: indexPath) as? JournalDashboardCollectionViewCell
        let entry = user?.journalEntries![indexPath.row]
        cell?.entry = entry
        return cell ?? UICollectionViewCell()
    }
}
