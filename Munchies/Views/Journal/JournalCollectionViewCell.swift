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
    var entry: Entry? {
        didSet{
            updateViews()
        }
    }
    
    
    //MARK: - Helper Methods
    func updateViews(){
        guard let entry = entry else {return}
        pictureView.image = entry.photo
        dishNameLabel.text = entry.title
        dateLabel.text = entry.timestamp.dateAsString()
    }
}
