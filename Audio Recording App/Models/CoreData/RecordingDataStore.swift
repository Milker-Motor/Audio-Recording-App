//
//  RecordingDataStore.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 24.11.2025.
//

import Foundation

protocol RecordingDataStore {
    func insert(_ item: LocalRecordingItem) throws
    func fetchAll() async throws -> [RecordingItem] 
}
