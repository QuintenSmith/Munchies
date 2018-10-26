//
//  ItemController.swift
//  Munchies
//
//  Created by Quinten Smith on 10/23/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation
import CloudKit

class ItemController {
    
    //MARK: - Singelton
    static let shared = ItemController()
    private init() {}
    
    
    //MARK: - Create new Grocery item
    func createItem(user: User, item: String, completion: @escaping (Item?) -> Void) {
        let item = Item.init(name: item, user: user) 
        user.shoppingList?.append(item)
        
        CKContainer.default().publicCloudDatabase.save(CKRecord(item)) { (record, error) in
            if let error = error {
                print("Error saving topic \(error) \(error.localizedDescription)")
                completion(nil); return
            }
            completion(item)
        }
    }
    
    
    //MARK: - Fetch grocery items
    func fetchItemsfor(user: User, completion: @escaping (Bool) -> Void) {
        let userReference = user.cloudKitRecordID
        let predicate = NSPredicate.init(format: "UserReference == %@", userReference)
        let itemIDs = user.shoppingList?.compactMap({$0.recordID})
        let predicate2 = NSPredicate(format: "NOT(recordID IN %@)", itemIDs!)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, predicate2])
        let query = CKQuery.init(recordType: "Item", predicate: compoundPredicate)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching items: \(error) \(error.localizedDescription)")
                completion(false); return
            }
            guard let records = records else {completion(false); return}
            let items = records.compactMap{ Item(record: $0)}
            user.shoppingList?.append(contentsOf: items)
            completion(true)
        }
    }
    
    
    //MARK: - Delete Grocery item(s)
    func deleteItem(item: Item, index: Int) {
        let recordID = item.recordID
        let modifyRecordOp = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [recordID])
        modifyRecordOp.qualityOfService = .userInteractive
        CKContainer.default().publicCloudDatabase.add(modifyRecordOp)
    }
}
