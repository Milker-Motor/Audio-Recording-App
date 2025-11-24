//
//  CoreDataRecordingStore.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 24.11.2025.
//

import CoreData

final class CoreDataRecordingStore {
    private static let modelName = "CoreDataRecordingStore"
    private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataRecordingStore.self))
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    enum StoreError: Error {
        case modelNotFound
        case failedToLoadPersistentContainer(Error)
    }
    
    init(storeURL: URL) throws {
        guard let model = CoreDataRecordingStore.model else {
            throw StoreError.modelNotFound
        }
        
        do {
            container = try NSPersistentContainer.load(name: CoreDataRecordingStore.modelName, model: model, url: storeURL)
            context = container.newBackgroundContext()
        } catch {
            throw StoreError.failedToLoadPersistentContainer(error)
        }
    }
    
    deinit {
        cleanUpReferencesToPersistentStores()
    }
    
    func perform(_ action: (NSManagedObjectContext) throws -> Void) throws {
        let context = self.context
        var caughtError: Error?
        
        context.performAndWait {
            do {
                try action(context)
            } catch {
                caughtError = error
            }
        }
        
        if let caughtError = caughtError {
            throw caughtError
        }
    }
    
    private func cleanUpReferencesToPersistentStores() {
        context.perform {
            let coordinator = self.container.persistentStoreCoordinator
            try? coordinator.persistentStores.forEach(coordinator.remove)
        }
    }
}

extension CoreDataRecordingStore: RecordingDataStore {
    func insert(_ item: LocalRecordingItem) throws {
        try perform { context in
            guard let fileURL = item.fileURL else { throw AppError.recordingFailed("Saving failed")}
            let newItem = RecordingItem(context: context)
            let attrs = try FileManager.default.attributesOfItem(atPath: fileURL.path)
            
            newItem.id = UUID()
            newItem.name = fileURL.lastPathComponent
            newItem.fileURL = fileURL
            newItem.duration = Int64(item.duration)
            newItem.fileSize = attrs[.size] as? Int64 ?? 0
            newItem.createdAt = Date()
            newItem.format = item.format.rawValue
            
            try context.save()
        }
    }
    
    func fetchAll() async throws -> [RecordingItem] {
        var items = [RecordingItem]()
        try perform { context in
            let request = NSFetchRequest<RecordingItem>(entityName: RecordingItem.entity().name!)
            request.returnsObjectsAsFaults = false
            
            items = try context.fetch(request)
        }
        return items
    }
}
