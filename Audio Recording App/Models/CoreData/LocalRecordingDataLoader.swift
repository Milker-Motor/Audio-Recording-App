//
//  LocalRecordingDataLoader.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 24.11.2025.
//

import Foundation

final class LocalRecordingDataLoader {
    private let store: RecordingDataStore
    init(store: RecordingDataStore) {
        self.store = store
    }
}

extension LocalRecordingDataLoader: RecordingDataStore {
    func insert(_ item: LocalRecordingItem) throws {
        try store.insert(item)
    }
    
    func fetchAll() async throws -> [RecordingItem] {
        try await store.fetchAll()
    }
}




//protocol RecordingCache {
//    func insert(_ recordig: RecordingItem) async throws
//}
//
//extension CoreDataRecordingStore: RecordingCache {
//    func insert(_ recordig: RecordingItem) async throws {
//        perform { context in
//            try RecordingItem.new
//            completion(Result {
//                let managedCache = try ManagedCache.newUniqueInstance(in: context)
//                
//                managedCache.timestamp = timestamp
//                managedCache.feed = ManagedFeedImage.images(from: feed, in: context)
//                
//                try context.save()
//            })
//        }
//    }
//}
