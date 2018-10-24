//
//  UserController.swift
//  Munchies
//
//  Created by Quinten Smith on 10/22/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit
import CloudKit
import UserNotifications

class UserController {
    
    static let shared = UserController()
    private init() {}
    
    var loggedInUser: User?
    
    func createUserWith(name: String, diet: String, intolerances: Set<String>, completion: @escaping (Bool) -> Void) {
        
        CKContainer.default().fetchUserRecordID { (appleUserRecordID, error) in
            
            if let error = error {
                print("Error fetching user record ID \(error) \(error.localizedDescription)")
                completion(false); return
            }
            
            guard let appleUserRecordID = appleUserRecordID else {completion(false); return}
            
            let refToAppleUser = CKRecord.Reference(recordID: appleUserRecordID, action: .deleteSelf)
            
            let user = User(name: name, diet: diet, intolerances: intolerances, shoppingList: nil, favorites: nil, journalEntries: nil, appleUserReference: refToAppleUser)
            
            let record = CKRecord(user: user)
            
            self.modifyRecords([record], perRecordCompletion: nil, completion: { (records, error) in
                if records?.isEmpty == true {
                    self.saveUser(user: user, completion: { (success) in
                        if success {
                            completion(true)
                        } else {
                            completion(false)
                            return
                        }
                    })
                }
                if let error = error {
                    self.saveUser(user: user, completion: { (success) in
                        if success {
                            completion(true)
                        } else {
                            print("Error saving user to database: \(error) \(error.localizedDescription)")
                            completion(false)
                            return
                        }
                    })
                }
                
                guard let records = records,
                    let record = records.first,
                    let user = User(ckRecord: record)
                    else {completion(false); return}
                self.loggedInUser = user
                completion(true)
            })
        }
        
    }
        func modifyRecords(_ records: [CKRecord], perRecordCompletion: ((_ record: CKRecord?, _ error: Error?) -> Void)?, completion: ((_ records: [CKRecord]?, _ error: Error?) -> Void)?) {
            
            let operation = CKModifyRecordsOperation(recordsToSave: records, recordIDsToDelete: nil)
            operation.savePolicy = .changedKeys
            operation.queuePriority = .high
            operation.qualityOfService = .userInteractive
            
            operation.perRecordCompletionBlock = perRecordCompletion
            
            operation.modifyRecordsCompletionBlock = { (records, recordID, error) -> Void in
                (completion?(records, error))!
            }
            CKContainer.default().publicCloudDatabase.add(operation)
        }
    
    func saveUser(user: User, completion: @escaping ((Bool) -> Void)) {
        let record = CKRecord(user: user)
        CKContainer.default().publicCloudDatabase.save(record) { (_, error) in
            if let error = error {
                print("Error creating User: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
            
        }
    }
    
    func fetchCurrentUser(completion: @escaping(Bool) -> Void) {
        CKContainer.default().fetchUserRecordID { (appleUserRecordID, error) in
            if let error = error {
                print("There was an error fetching current user ID \(error) \(error.localizedDescription)")
                completion(false); return
            }
            guard let appleUserRecordID = appleUserRecordID else {completion(false); print("🐳🐳🐳"); return}
            let predicate = NSPredicate(format: "appleUserReference == %@", appleUserRecordID)
            let query = CKQuery(recordType: "User", predicate: predicate)
            
            CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil
                , completionHandler: { (records, error) in
                    if let error = error {
                        print("There was an problem fetching current user \(error) \(error.localizedDescription)")
                        completion(false); return
                    }
                    
                    guard let currentUserRecord = records?.first,
                          let user = User(ckRecord: currentUserRecord)
                        else { completion(false); return }
                    self.loggedInUser = user
                    completion(true)
            })
            
        }
        
    }
    
    func updateUser(user: User, name: String, diet: String?, intolerances: Set<String>, shoppingList: [GroceryItem]?,
                    favorites: [RecipeID]?, journalEntries: [Entry]?, completion: @escaping(Bool) -> Void) {
        
        user.name = name
        user.diet = diet
        user.intolerances = intolerances
        user.shoppingList = shoppingList
        user.favorites = favorites
        user.journalEntries = journalEntries
        let updatedUserRecord = CKRecord(user: user)
        var recordsToSave: [CKRecord] = []
        recordsToSave.append(updatedUserRecord)
        let operation = CKModifyRecordsOperation(recordsToSave: recordsToSave, recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive
        operation.completionBlock = {
            self.loggedInUser = user
            completion(true)
        }
        CKContainer.default().publicCloudDatabase.add(operation) 
    }
    
}

