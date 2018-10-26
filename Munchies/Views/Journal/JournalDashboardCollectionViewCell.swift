//
//  JournalDashboardCollectionViewCell.swift
//  Munchies
//
//  Created by Quinten Smith on 10/18/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class JournalDashboardCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    //MARK: - Properties
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    
    //MARK: - UpdateViews
    func updateViews() {
        guard  let entry = entry else {return}
        imageView.image = entry.photo
        nameLabel.text = entry.title
        timeLabel.text = entry.timestamp.dateAsString()
    }
}
