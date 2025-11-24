//
//  PlaceholderViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import Foundation

final class PlaceholderViewModel: ObservableObject {
    private let recordingState: RecordingState
    init(recordingState: RecordingState) {
        self.recordingState = recordingState
    }
    
    func onPlay() {
        recordingState.startNewRecording()
    }
}

//extension PlaceholderViewModel: Recordable {
//    func startNewRecording() throws {
//        recordingState.mode = .recording
//    }
//    
//    func stopRecording() {
//        recordingState.mode = .playback
//    }
//}
