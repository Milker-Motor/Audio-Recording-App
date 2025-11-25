//
//  RecordingService.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import SwiftUI

final class RecordingService: ObservableObject {
    @ObservedObject private(set) var state: RecordingState
    
    let audioRecorder: AudioRecorderProtocol
    let dataStore: RecordingDataStore
    init(audioRecorder: AudioRecorderProtocol, dataStore: RecordingDataStore, state: RecordingState) {
        self.state = state
        self.audioRecorder = audioRecorder
        self.dataStore = dataStore
    }
}

extension RecordingService: Recordable {
    
    var isRecording: Bool {
        audioRecorder.isRecording
    }
    
    func updateMeters() {
        audioRecorder.updateMeters()
    }
    
    func startNewRecording() async throws {
//        Task {
//            do {
                try await audioRecorder.startRecording(to: state.url(state.format.rawValue), format: state.format, sampleRate: state.sampleRate)
                state.startNewRecording()
//            } catch {
//                state.pauseRecording()
//                throw error
//            }
            
//        }
        
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
    
    func averagePower(forChannel channelNumber: Int) -> Float {
        audioRecorder.averagePower(forChannel: channelNumber)
    }
}
