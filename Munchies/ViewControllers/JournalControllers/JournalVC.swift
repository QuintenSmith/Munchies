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
    
    
    //MARK: - Properties
    var user: User?
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        user = UserController.shared.loggedInUser
        EntryController.shared.fetchEntries(user: user!) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        guard let shoppingList = user?.shoppingList else {return}
        if shoppingList.count >= 1 {
            self.collectionView.isHidden = false
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        sideMenu()
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
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
        return user?.journalEntries!.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JournalCell", for: indexPath) as? JournalCollectionViewCell else {return UICollectionViewCell()}
        let entry = user?.journalEntries![indexPath.row]
        cell.entry = entry 
        return cell
    }
    
    
    //MARK: - Navigation to detail view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailView" {
            if let cell = sender as? UICollectionViewCell, let indexPath = self.collectionView.indexPath(for: cell) {
                let entry = user?.journalEntries![indexPath.row]
                let destinationVC = segue.destination as? JournalEntryDetailVC
                destinationVC?.entry = entry
            }
        }
    }
}
