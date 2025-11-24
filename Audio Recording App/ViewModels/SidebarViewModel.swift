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
    private let _onSelect: (RecordingRowItem) -> Void
    
    var selectedRecording: RecordingRowItem? {
        didSet {
            if let selectedRecording {
                _onSelect(selectedRecording)
            }
        }
    }
    
    @Published private(set) var recordings: [RecordingRowItem] = []
    
    init(dataStore: RecordingDataStore, onPlay: @escaping () -> Void, onSelect: @escaping (RecordingRowItem) -> Void) {
        self.dataStore = dataStore
        self._onPlay = onPlay
        self._onSelect = onSelect
        
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
                durationInSeconds: Int(item.duration),
                date: item.createdAt.formatted(date: .abbreviated, time: .shortened),
                url: item.fileURL
            )
        }
    }
}
