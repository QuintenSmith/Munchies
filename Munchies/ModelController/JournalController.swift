//
//  JournalController.swift
//  Munchies
//
//  Created by Kamil Wrobel on 10/19/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation


class JournalController {
    
    //MARK: - Singelton
    static let shared = JournalController()
    private init() {}
    
    //MARK: - Properties
    var journalEntries : [JournalEntry] = []
    
    
    
    //MARK: - CRUD Methods
    func save(entry: JournalEntry){
        journalEntries.append(entry)
    }
    
    
    func delete(entry: JournalEntry){
        guard let index = journalEntries.index(of: entry) else {return}
        journalEntries.remove(at: index)
        
    }
    
    
    
}
