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
    let dataStore: RecordingDataStore
    init(audioRecorder: AudioRecorderProtocol, dataStore: RecordingDataStore, state: RecordingState) {
        self.state = state
        self.audioRecorder = audioRecorder
        self.dataStore = dataStore
    }
}

extension RecordingManager: Recordable {
    func startNewRecording() throws {
        state.startNewRecording()
        try audioRecorder.startRecording(to: state.url(state.format.rawValue), format: state.format, sampleRate: state.sampleRate)
    }
    
    func stopRecording() throws -> URL? {
        state.stopRecording()
        return audioRecorder.stopRecording()
    }
    
    func pauseRecording() {
        state.pauseRecording()
        audioRecorder.pauseRecording()
    }
    
    func resumeRecording() {
        state.resumeRecording()
        audioRecorder.resumeRecording()
    }
}
