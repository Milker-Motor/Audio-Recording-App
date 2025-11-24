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
    
    init(recordable: Recordable, dataStore: RecordingDataStore, state: RecordingState) {
        self.recordable = recordable
        self.dataStore = dataStore
        self.recordingStatable = state
    }
    
    var mode: DetailMode {
        switch recordingStatable.state {
        case .stopped:
            return .none
        case .recording:
            return .recording
        case .paused:
            return .recording
        }
    }
}
