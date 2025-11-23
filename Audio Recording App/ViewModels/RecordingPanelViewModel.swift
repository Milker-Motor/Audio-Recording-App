//
//  RecordingPanelViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import Foundation

final class RecordingPanelViewModel: ObservableObject {
    @Published private(set) var timer: String
    private let recordableState: RecordingState
    
    init(timer: String = "00:00", recordableState: RecordingState) {
        self.timer = timer
        self.recordableState = recordableState
    }
    
    var isPaused: Bool {
        recordableState.isPaused
    }
}
