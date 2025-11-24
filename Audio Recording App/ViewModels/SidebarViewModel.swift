//
//  SidebarViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import Foundation

final class SidebarViewModel: ObservableObject {
    private let dataStore: RecordingDataStore
    private let _onPlay: () -> Void
    
    @Published private(set) var recordings: [RecordingRowItem] = []
    
    init(dataStore: RecordingDataStore, onPlay: @escaping () -> Void) {
        self.dataStore = dataStore
        self._onPlay = onPlay
        
        Task {
            recordings = try! await dataStore.fetchAll().toLocal()
        }
    }
    
    func startNewRecording() {
        _onPlay()
    }
}

extension Array where Element == RecordingItem {
    func toLocal() -> [RecordingRowItem] {
        map { item in
            RecordingRowItem(
                name: item.name,
                duration: String(format: "%02d:%02d", item.duration / 60, item.duration % 60),
                date: item.createdAt.formatted(date: .abbreviated, time: .shortened),
                fileExist: item.fileURL != nil
            )
        }
    }
}
