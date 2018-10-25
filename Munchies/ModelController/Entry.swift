//
//  Entry.swift
//  Munchies
//
//  Created by Quinten Smith on 10/22/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import UIKit
import CloudKit

class Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.timestamp == rhs.timestamp
    }
    
    
    var recordID = CKRecord.ID(recordName: UUID().uuidString)
    var photoData: Data?
    var timestamp: Date
    var title: String
    var description: String
    var tempURL: URL?
    weak var user: User?
    
    var photo: UIImage? {
        get {
            guard let photoData = photoData else {return nil}
            return UIImage(data: photoData)
        }
        set {
            photoData = newValue?.jpegData(compressionQuality: 0.6)
        }
    }
    
    init(user: User?, photo: UIImage?, timestamp: Date = Date(), title: String, description: String) {
        self.timestamp = timestamp
        self.title = title
        self.description = description
        self.photo = photo
        self.user = user
    }
    
    var imageAsset: CKAsset? {
        get {
            let tempDirectory = NSTemporaryDirectory()
            let tempDirecotryURL = URL(fileURLWithPath: tempDirectory)
            let fileURL = tempDirecotryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
            self.tempURL = fileURL
            do {
                try photoData?.write(to: fileURL)
            } catch let error {
                print("Error writing to temp url \(error) \(error.localizedDescription)")
            }
            return CKAsset(fileURL: fileURL)
        }
    }
    
    deinit {
        if let url = tempURL {
            do {
                try FileManager.default.removeItem(at: url)
            } catch let error {
                print("Error deleting temp file, or may cause memory leak: \(error)")
            }
        }
    }
    
    init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryKeys.titleKey] as? String,
              let timestamp = ckRecord.creationDate,
              let imageAsset = ckRecord[EntryKeys.photoDataKey] as? CKAsset,
              let description = ckRecord[EntryKeys.descriptionKey] as? String else {return nil}
        guard let photoData = try? Data(contentsOf: imageAsset.fileURL) else {return nil}
        
        self.title = title
        self.timestamp = timestamp
        self.photoData = photoData
        self.description = description
        self.recordID = ckRecord.recordID
    }
}

extension CKRecord {
    convenience init(_ entry: Entry) {
        guard let user = entry.user else {
            fatalError("Entry has no relationship")
        }
        self.init(recordType: EntryKeys.TypeKey, recordID: entry.recordID)
        self.setValue(entry.title, forKey: EntryKeys.titleKey)
        self.setValue(entry.timestamp, forKey: EntryKeys.timeStampKey)
        self.setValue(entry.description, forKey: EntryKeys.descriptionKey)
        self.setValue(entry.imageAsset, forKey: EntryKeys.photoDataKey)
        self.setValue(CKRecord.Reference(recordID: user.cloudKitRecordID, action: .deleteSelf), forKey: EntryKeys.userReference)
    }
}

struct EntryKeys {
    static let TypeKey = "Entry"
    static let timeStampKey = "Timestamp"
    static let photoDataKey = "PhotoData"
    static let titleKey = "Title"
    static let descriptionKey = "Description"
    static let userReference = "UserReference"
}
