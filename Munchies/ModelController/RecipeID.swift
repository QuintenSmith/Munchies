//
//  RecipeID.swift
//  Munchies
//
//  Created by Quinten Smith on 10/23/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation
import CloudKit

class RecipeID {
    
    var recordID = CKRecord.ID(recordName: UUID().uuidString)
    var recipeID: Int
    weak var user: User?
    
    init(recipeID: Int, user: User?) {
        self.recipeID = recipeID
        self.user = user
    }
    
    convenience required init?(record: CKRecord) {
        guard let recipeID = record[RecipeIDKeys.recipeIDKey] as? Int else {return nil}
        self.init(recipeID: recipeID, user: nil)
        self.recordID = record.recordID
    }
}

extension CKRecord {
    convenience init(_ recipeID: RecipeID) {
        guard let user = recipeID.user else {
            fatalError("RecipeID has no relationship")
        }
        self.init(recordType: RecipeIDKeys.TypeKey, recordID: recipeID.recordID)
        self.setValue(recipeID.recipeID, forKey: RecipeIDKeys.recipeIDKey)
        self.setValue(CKRecord.Reference(recordID: user.cloudKitRecordID, action: .deleteSelf), forKey: RecipeIDKeys.userReference)
    }
}

struct RecipeIDKeys {
    static let TypeKey = "RecipeID"
    static let recipeIDKey = "recipeID"
    static let userReference = "UserReference"
}

