//
//  RecordingItem.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 24.11.2025.
//

import CoreData

@objc(RecordingItem)
class RecordingItem: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var createdAt: Date
    @NSManaged var duration: Int64
    @NSManaged var fileURL: URL?
    @NSManaged var fileSize: Int64
    @NSManaged var format: String
}
