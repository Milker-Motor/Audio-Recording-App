//
//  RecordingManager.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import SwiftUI

final class RecordingManager: ObservableObject {
    @ObservedObject private(set) var state: RecordingState
    let audioRecorder: AudioRecorderProtocol
    init(audioRecorder: AudioRecorderProtocol, state: RecordingState) {
        self.state = state
        self.audioRecorder = audioRecorder
    }
}

extension RecordingManager: Recordable {
    func startNewRecording() throws {
        state.mode = .recording
        try audioRecorder.startRecording(to: state.url(state.format.rawValue), format: state.format, sampleRate: state.sampleRate)
    }
}
