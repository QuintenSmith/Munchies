//
//  JournalCollectionViewCell.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class JournalCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    //MARK: - Properties
    var entry: JournalEntry? {
        didSet{
            updateViews()
        }
    }
    
    
    
    //MARK: - Helper Methods
    func updateViews(){
        guard let journalEntry = entry else {return}
        pictureView.image = journalEntry.picture
        dishNameLabel.text = journalEntry.title
        dateLabel.text = journalEntry.date.dateAsString()
        
    }
    
    
    
    
}
