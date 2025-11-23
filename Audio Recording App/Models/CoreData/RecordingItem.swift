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
    @NSManaged var createdAt: Date
    @NSManaged var duration: Double
    @NSManaged var fileURL: URL
}
