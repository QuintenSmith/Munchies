//
//  Item.swift
//  Munchies
//
//  Created by Quinten Smith on 10/22/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation
import CloudKit

class Item {
    
    var recordID = CKRecord.ID(recordName: UUID().uuidString)
    let name: String
    weak var user: User?
    
    init(name: String, user: User?) {
        self.name = name
        self.user = user
    }
    
    convenience required init?(record: CKRecord) {
        guard let name = record[ItemKeys.nameKey] as? String else {return nil}
        self.init(name: name, user: nil)
        self.recordID = record.recordID
    }
    
}

extension CKRecord {
    convenience init(_ item: Item) {
        guard let user = item.user else {
            fatalError("Item has no relationship")
        }
        self.init(recordType: ItemKeys.TypeKey, recordID: item.recordID)
        self.setValue(item.name, forKey: ItemKeys.nameKey)
        self.setValue(CKRecord.Reference(recordID: user.cloudKitRecordID, action: .deleteSelf), forKey: ItemKeys.userReference)
    }
}

struct ItemKeys {
    static let TypeKey = "Item"
    static let nameKey = "Name"
    static let userReference = "UserReference"
}
