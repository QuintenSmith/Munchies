//
//  EntryController.swift
//  Munchies
//
//  Created by Quinten Smith on 10/24/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit
import CloudKit

class EntryController {
    
    //MARK: - Singelton
    static let shared = EntryController()
    private init() {}
    
    
    //MARK: - Create New Journal Entry
    func createEntryWith(user: User, image: UIImage, title: String, description: String, completion: @escaping (Entry?) -> Void) {
        let entry = Entry(user: user, photo: image, title: title, description: description)
        user.journalEntries?.append(entry)
        CKContainer.default().publicCloudDatabase.save(CKRecord(entry)) { (_, error) in
            if let error = error {
                print("Error saving entry \(error) \(error.localizedDescription)")
                completion(nil); return
            }
            completion(entry)
        }
    }
    
    
    //MARK: - Fetch Journal Entries
    func fetchEntries(user: User, completion: @escaping (Bool) -> Void) {
        let userReference = user.cloudKitRecordID
        let predicate = NSPredicate.init(format: "UserReference == %@", userReference)
        let entryIDs = user.journalEntries?.compactMap({$0.recordID})
        let predicate2 = NSPredicate(format: "NOT(recordID IN %@)", entryIDs!)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, predicate2])
        let query = CKQuery.init(recordType: "Entry", predicate: compoundPredicate)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching entries \(error) \(error.localizedDescription)")
                completion(false); return
            }
            guard let records = records else {completion(false); return}
            let entry = records.compactMap{ Entry(ckRecord: $0) }
            user.journalEntries?.append(contentsOf: entry)
            completion(true)
        }
    }
    
    
    //MARK: - Delete Journal Entry
    func deleteItem(item: Entry) {
        let recordID = item.recordID
        let modifyRecordOp = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [recordID])
        modifyRecordOp.qualityOfService = .userInteractive
        CKContainer.default().publicCloudDatabase.add(modifyRecordOp)
        guard let user = UserController.shared.loggedInUser else { return }
        guard let index = user.journalEntries!.index(of: item) else {return}
        user.journalEntries?.remove(at: index)
    }
}
