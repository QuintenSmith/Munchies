//
//  Item.swift
//  Munchies
//
//  Created by Quinten Smith on 10/22/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation
import CloudKit

class Item : Equatable{
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        if lhs.name != rhs.name {return false}
        return true
    }
    
    
    var recordID = CKRecord.ID(recordName: UUID().uuidString)
    let name: String
    var isSelected: Bool
    weak var user: User?
    
    init(name: String, isSelected: Bool = false, user: User?) {
        self.name = name
        self.isSelected = isSelected
        self.user = user
    }
    
    convenience required init?(record: CKRecord) {
        guard let name = record[ItemKeys.nameKey] as? String,
              let isSelected = record[ItemKeys.isSelectedKey] as? Bool else {return nil}
        self.init(name: name, isSelected: isSelected, user: nil)
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
        self.setValue(item.isSelected, forKey: ItemKeys.isSelectedKey)
        self.setValue(CKRecord.Reference(recordID: user.cloudKitRecordID, action: .deleteSelf), forKey: ItemKeys.userReference)
    }
}

struct ItemKeys {
    static let TypeKey = "Item"
    static let nameKey = "Name"
    static let isSelectedKey = "isSelected"
    static let userReference = "UserReference"
}
