//
//  JournalDashboardVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/18/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class JournalDashboardVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var backgroundImg: UIView!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundView = backgroundImg
        user = UserController.shared.loggedInUser
        var numberOfRows = 0
        guard let journalEntries = user?.journalEntries else {return}
        if journalEntries.count > 6 {
            numberOfRows = 6
        } else {
            numberOfRows = journalEntries.count
        }

        let datasource = JournalCollectionViewDataSource(numberOfItems: numberOfRows, entries: journalEntries)
        collectionView.dataSource = datasource
        NSLog("po %@", datasource)
        if datasource.numberOfItems >= 1 {
            self.collectionView.backgroundView?.isHidden = true
        } else {
            self.collectionView.backgroundView?.isHidden = false
        }
        
        collectionView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
        
//         self.collectionView.backgroundView = backgroundImg
//        user = UserController.shared.loggedInUser
//        var numberOfRows = 0
//        guard let journalEntries = user?.journalEntries else {return}
//        if journalEntries.count > 6 {
//            numberOfRows = 6
//        } else {
//            numberOfRows = journalEntries.count
//        }
//
//        let datasource = JournalCollectionViewDataSource(numberOfItems: numberOfRows, entries: journalEntries)
//        collectionView.dataSource = datasource
//        NSLog("po %@", datasource)
//        if datasource.numberOfItems >= 1 {
//            self.collectionView.backgroundView?.isHidden = true
//        } else {
//            self.collectionView.backgroundView?.isHidden = false
//        }
    }
    
}
