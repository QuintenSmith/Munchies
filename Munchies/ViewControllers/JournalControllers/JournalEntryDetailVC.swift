//
//  JournalEntryVC.swift
//  Munchies
//
//  Created by Quinten Smith on 10/17/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class JournalEntryDetailVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var entryImageView: UIImageView!
    @IBOutlet weak var entryTitleLabel: UILabel!
    @IBOutlet weak var entryDateLabel: UILabel!
    @IBOutlet weak var entrydescriptionTextView: UITextView!
    
    
    //MARK: - Properties
    var entry: JournalEntry? {
        didSet{
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewIfNeeded()
        updateViews()
        
    }
    
    
    //MARK: - Actions
    @IBAction func deleteButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Entry?", message: "Are you sure you want to delete this food journal entry?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            guard let entry = self.entry else {return}
            JournalController.shared.delete(entry: entry)
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    
    //MARK: - Helper Methods
    func updateViews(){
        guard let entry = entry else {return}
        entryImageView.image = entry.picture
        entryDateLabel.text = entry.date.dateAsString()
        entryTitleLabel.text = entry.title
        entrydescriptionTextView.text = entry.description
    }
    
}
