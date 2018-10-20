//
//  JournalEntry.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/11/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit

class JournalEntry: Equatable {
    
    
    var picture : UIImage
    var date : Date
    var title: String
    var description: String?
    
    init(picture: UIImage, title: String, description: String?, date: Date = Date()) {
        self.picture = picture
        self.title = title
        self.description = description
        self.date = date
    }
    
    static func == (lhs: JournalEntry, rhs: JournalEntry) -> Bool {
        if lhs.title != rhs.title {return false}
        if lhs.picture != rhs.picture {return false}
        if lhs.description != rhs.description {return false}
        if lhs.date != rhs.date {return false}
        return true
    }
    
}
