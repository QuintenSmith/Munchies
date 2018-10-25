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
    static let shared = EntryController()
    
    private init() {}
    
    var entries: [Entry] = []
    
    func createEntryWith(user: User, image: UIImage, title: String, description: String, completion: @escaping (Entry?) -> Void) {
        let entry = Entry(user: user, photo: image, title: title, description: description)
        entries.append(entry)
        CKContainer.default().publicCloudDatabase.save(CKRecord(entry)) { (_, error) in
            if let error = error {
                print("Error saving entry \(error) \(error.localizedDescription)")
                completion(nil); return
            }
            completion(entry)
        }
    }
    
    func fetchEntries(completion: @escaping([Entry]?) -> Void) {
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Entry", predicate: predicate)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching entries \(error) \(error.localizedDescription)")
                completion(nil); return
            }
            guard let records = records else {completion(nil); return}
            let entries = records.compactMap{ Entry(ckRecord: $0) }
            
            self.entries = entries
            completion(entries) 
        }
    }
}
