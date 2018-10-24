//
//  ItemController.swift
//  Munchies
//
//  Created by Quinten Smith on 10/23/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

//import Foundation
//import CloudKit
//
//class ItemController {
//    static let shared = ItemController()
//    
//    private init() {}
//    
//    func createItem(user: User, item: String, completion: @escaping (Item?) -> Void) {
//        let item = Item.init(name: item, user: user)
//
//        user.shoppingList?.append(item)
//
//        CKContainer.default().publicCloudDatabase.save(CKRecord(item)) { (record, error) in
//            if let error = error {
//                print("Error saving topic \(error) \(error.localizedDescription)")
//                completion(nil); return
//            }
//            completion(item)
//        }
//    }
//}
