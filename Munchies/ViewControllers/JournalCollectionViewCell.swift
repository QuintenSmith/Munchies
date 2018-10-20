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
    var cellData: JournalEntry? {
        didSet{
            updateViews()
        }
    }
    
    
    
    //MARK: - Helper Methods
    func updateViews(){
        guard let recipe = cellData else {return}
        pictureView.image = recipe.picture
        dishNameLabel.text = recipe.title
        dateLabel.text = recipe.date.dateAsString()
        
    }
    
    
    
    
}
