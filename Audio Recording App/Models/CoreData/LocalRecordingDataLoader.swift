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
    func insert(_ item: LocalRecordingItem) throws -> RecordingItem {
        try store.insert(item)
    }
    
    func fetchAll() async throws -> [RecordingItem] {
        try await store.fetchAll()
    }
}
