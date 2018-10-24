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
    var intolerances: Set<String>?
    var shoppingList: [Item]?
    var favorites: [RecipeID]?
    var journalEntries: [Entry]?
    
    var cloudKitRecordID = CKRecord.ID(recordName: UUID().uuidString) 
    let appleUserReference: CKRecord.Reference
    
    init(name: String, diet: String?, intolerances: Set<String>?, shoppingList: [Item]?, favorites: [RecipeID]?, journalEntries: [Entry]?, appleUserReference: CKRecord.Reference) {
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
        
        var intolerances: Set<String>?
        if let intoleranceStringsArray = ckRecord[Constants.intolerancesKey] as? [String]{
            let intolerancesArray = intoleranceStringsArray.compactMap{ String( $0 )}
            intolerances = Set(intolerancesArray)
        }
        
        self.name = name
        self.diet = diet
        
        
        self.intolerances = intolerances
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
        
        var intoleranceStrings: [String] = []
        for intolerance in user.intolerances!{
            let singleIntoleranceString = intolerance
            intoleranceStrings.append(singleIntoleranceString)
        }
        
        self.setValue(intoleranceStrings, forKey: Constants.intolerancesKey)
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

