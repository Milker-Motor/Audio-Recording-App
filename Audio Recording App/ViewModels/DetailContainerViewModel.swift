//
//  DetailContainerViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import Foundation

final class DetailContainerViewModel: ObservableObject {
    private(set) var recordable: Recordable
    private(set) var recordingStatable: RecordingState
    let dataStore: RecordingDataStore
    let playback: PlaybackManagerProtocol
    @Published var detailMode: DetailMode
    
    init(recordable: Recordable, dataStore: RecordingDataStore, playback: PlaybackManagerProtocol, state: RecordingState, detailMode: DetailMode) {
        self.recordable = recordable
        self.dataStore = dataStore
        self.playback = playback
        self.recordingStatable = state
        self.detailMode = detailMode
        
    }
    
//    var mode: DetailMode {
//        switch recordingStatable.state {
//        case .stopped:
//            return .none
//        case .recording:
//            return .recording
//        case .paused:
//            return .recording
//        }
//    }
}
