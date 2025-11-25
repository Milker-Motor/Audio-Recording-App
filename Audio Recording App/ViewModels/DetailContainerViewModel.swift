//
//  DetailContainerViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import Foundation

final class DetailContainerViewModel: ObservableObject {
    private(set) var recordable: Recordable
    let dataStore: RecordingDataStore
    let playback: PlaybackManagerProtocol
    @Published var detailMode: DetailMode
    
    init(recordable: Recordable, dataStore: RecordingDataStore, playback: PlaybackManagerProtocol, detailMode: DetailMode) {
        self.recordable = recordable
        self.dataStore = dataStore
        self.playback = playback
        self.detailMode = detailMode
        
    }
}
