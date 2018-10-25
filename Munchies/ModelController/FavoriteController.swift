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
}
