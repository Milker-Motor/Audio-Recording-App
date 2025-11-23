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
    
    init(recordable: Recordable, state: RecordingState) {
        self.recordable = recordable
        self.recordingStatable = state
    }
}
