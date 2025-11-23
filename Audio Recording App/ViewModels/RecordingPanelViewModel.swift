//
//  RecordingPanelViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import SwiftUI

final class RecordingPanelViewModel: ObservableObject {
    @ObservedObject private(set) var recordableState: RecordingState
    
    init(recordableState: RecordingState) {
        self.recordableState = recordableState
    }
    
    var isPaused: Bool {
        recordableState.isPaused
    }
    
    var timer: String {
        let duration = recordableState.secondsPlayback
        return String(format: "%02d:%02d", duration / 60, duration % 60)
    }
}
