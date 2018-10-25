//
//  JournalVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/17/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class JournalVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        sideMenu()
//        EntryController.shared.fetchEntries { (entries) in
//            if entries != nil {
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
//            }
//        }
        
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        EntryController.shared.fetchEntries { (entries) in
//            if entries != nil {
//
//            }
//        }
        if EntryController.shared.entries.count >= 1 {
            self.collectionView.isHidden = false
            
            DispatchQueue.main.async {
                                                                                                            self.collectionView.reloadData()
                                }
        }
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
    
    
    //MARK: - Colection View Data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JournalCell", for: indexPath) as? JournalCollectionViewCell else {return UICollectionViewCell()}
        let entry = EntryController.shared.entries[indexPath.row]
        cell.entry = entry 
        return cell
    }
    
    
    //MARK: - Navigation to detail view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailView" {
            if let cell = sender as? UICollectionViewCell, let indexPath = self.collectionView.indexPath(for: cell) {
                let entry = EntryController.shared.entries[indexPath.row]
                print("🅿️ \(entry.title)")
                let destinationVC = segue.destination as? JournalEntryDetailVC
                destinationVC?.entry = entry
            }
        }
    }
    
    
}
