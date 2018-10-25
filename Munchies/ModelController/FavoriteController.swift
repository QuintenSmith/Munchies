//
//  FavoriteController.swift
//  Munchies
//
//  Created by Quinten Smith on 10/25/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation
import CloudKit

class FavoriteController {
    
    static let shared = FavoriteController()
    private init() {}
    
    func createFavorite(user: User, recipeID: Int, completion: @escaping (RecipeID?) -> Void) {
        let recipeID = RecipeID.init(recipeID: recipeID, user: user)
        user.favorites?.append(recipeID)
        
        CKContainer.default().publicCloudDatabase.save(CKRecord(recipeID)) { (record, error) in
            if let error = error {
                print("Error saving favorite recipe \(error) \(error.localizedDescription)")
            }
            completion(recipeID) 
        }
    }
    
    func fetchFavorites(user: User, completion: @escaping (Bool) -> Void) {
        
        let userReference = user.cloudKitRecordID
        let predicate = NSPredicate.init(format: "UserReference == %@", userReference)
        let recipeIDs = user.favorites?.compactMap({$0.recordID})
        let predicate2 = NSPredicate(format: "NOT(recordID IN %@)", recipeIDs!)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, predicate2])
        
        let query = CKQuery.init(recordType: "RecipeID", predicate: compoundPredicate)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching recipeIDs \(error) \(error.localizedDescription)")
                completion(false); return
            }
            guard let records = records else {completion(false); return}
            let recipeID = records.compactMap{ RecipeID(record: $0) }
            user.favorites?.append(contentsOf: recipeID)
            completion(true)
        }
    }
}
