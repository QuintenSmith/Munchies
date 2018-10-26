//
//  User.swift
//  Munchies
//
//  Created by Quinten Smith on 10/22/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation
import CloudKit

class User {
    
    var name: String
    var diet: String?
    var intolerances: [Intolerance]?
    var shoppingList: [Item]?
    var favorites: [DetailedRecipe]?
    var journalEntries: [Entry]?
    
    var cloudKitRecordID = CKRecord.ID(recordName: UUID().uuidString) 
    let appleUserReference: CKRecord.Reference
    
    init(name: String, diet: String?, intolerances: [Intolerance]?, shoppingList: [Item]?, favorites: [DetailedRecipe]?, journalEntries: [Entry]?, appleUserReference: CKRecord.Reference) {
        self.name = name
        self.diet = diet
        self.intolerances = intolerances
        self.shoppingList = shoppingList
        self.favorites = favorites
        self.journalEntries = journalEntries
        self.appleUserReference = appleUserReference
    }
    
    init?(ckRecord: CKRecord) {
        guard let name = ckRecord[Constants.nameKey] as? String,
              let diet = ckRecord[Constants.dietKey] as? String,
              let appleUserReference = ckRecord[Constants.appleUserReferenceKey] as? CKRecord.Reference else {return nil}
        
        self.name = name
        self.diet = diet
        self.intolerances = []
        self.shoppingList = []
        self.favorites = []
        self.journalEntries = []
        self.appleUserReference = appleUserReference
        self.cloudKitRecordID = ckRecord.recordID
    }
}

   extension CKRecord {
    convenience init(user: User) {
        let recordID = user.cloudKitRecordID 
        self.init(recordType: Constants.UserRecordType, recordID: recordID)
        self.setValue(user.name, forKey: Constants.nameKey)
        self.setValue(user.diet, forKey: Constants.dietKey)
        self.setValue(user.intolerances, forKey: Constants.intolerancesKey)
        self.setValue(user.shoppingList, forKey: Constants.shoppingListKey)
        self.setValue(user.favorites, forKey: Constants.favoritesKey)
        self.setValue(user.journalEntries, forKey: Constants.journalEntriesKey)
        self.setValue(user.appleUserReference, forKey: Constants.appleUserReferenceKey)
    }
}

    struct Constants {
        static let UserRecordType = "User"
        static let nameKey = "name"
        static let dietKey = "diet"
        static let intolerancesKey = "intolerances"
        static let shoppingListKey = "shoppingList"
        static let favoritesKey = "favorites"
        static let journalEntriesKey = "journalEntries"
        static let appleUserReferenceKey = "AppleUserReference"
    }

