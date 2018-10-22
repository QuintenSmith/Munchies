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
    var journalEntry: [JournalEntry]
    
    init(numberOfItems: Int, entries: [JournalEntry]){
        self.numberOfItems = numberOfItems
        self.journalEntry = entries
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if JournalController.shared.journalEntries.count > 6 {
        return numberOfItems
        } else {
            return JournalController.shared.journalEntries.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JournalCell", for: indexPath) as? JournalDashboardCollectionViewCell
        let entry = JournalController.shared.journalEntries[indexPath.row]
        cell?.entry = entry
        return cell ?? UICollectionViewCell()
    }
}
