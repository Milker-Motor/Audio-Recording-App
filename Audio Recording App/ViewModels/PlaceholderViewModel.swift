//
//  PlaceholderViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import Foundation

final class PlaceholderViewModel: ObservableObject {
    var recordingState: RecordingState
    init(recordingState: RecordingState) {
        self.recordingState = recordingState
    }
}

extension PlaceholderViewModel: Recordable {
    func startNewRecording() throws {
        recordingState.mode = .recording
    }
}
