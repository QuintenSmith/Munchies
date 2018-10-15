//
//  JournalEntry.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class JournalEntry {
    
    var picture : UIImage
    var date : Date
    var title: String
    var review: Int
    var description: String?
    
    init(picture: UIImage, title: String, description: String?,review: Int, date: Date = Date()) {
        self.picture = picture
        self.title = title
        self.description = description
        self.review = review
        self.date = date
    }
    
    
    //need properties for journal entries -
    
    //unless we put them separate under journal model
    
    //image - taken by user
    //date - recorder during creating entry
    //review - writen by the user
    //title - given by the user
    
    //FIXME: needed for creating journal entries, and for editing them
}
