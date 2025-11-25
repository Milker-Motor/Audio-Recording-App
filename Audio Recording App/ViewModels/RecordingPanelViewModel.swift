//
//  RecordingPanelViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import SwiftUI

final class RecordingPanelViewModel: ObservableObject {
    let recordable: Recordable
    private let dataStore: RecordingDataStore
    @Published var uiError: AppError?
    
    init(recordable: Recordable, dataStore: RecordingDataStore) {
        self.recordable = recordable
        self.dataStore = dataStore
    }
    
    var isPaused: Bool {
        state.state == .paused
    }
    
    var timer: String {
        let duration = state.secondsPlayback
        return String(format: "%02d:%02d", duration / 60, duration % 60)
    }
    
    func togglePauseResumeRecording() {
        if isPaused {
            recordable.resumeRecording()
        } else {
            recordable.pauseRecording()
        }
    }
}

extension RecordingPanelViewModel: Recordable {
    var state: RecordingState {
        recordable.state
    }
    
    var isRecording: Bool {
        recordable.isRecording
    }
    
    func updateMeters() {
        recordable.updateMeters()
    }
    
    func startNewRecording() async throws {
        do {
            try await recordable.startNewRecording()
        } catch {
            Task { @MainActor in
                self.uiError = error as? AppError
            }
        }
    }
    
    func stopRecording() throws -> URL? {
        var url: URL?
        do {
            url = try recordable.stopRecording()
        } catch {
            Task { @MainActor in
                self.uiError = .recordingFailed(error.localizedDescription)
            }
        }
        try dataStore.insert(LocalRecordingItem(fileURL: url, duration: state.secondsPlayback, format: state.format))
        return url
    }
    
    func resumeRecording() {
        recordable.resumeRecording()
    }
    
    func pauseRecording() {
        recordable.pauseRecording()
    }
    
    func averagePower(forChannel channelNumber: Int) -> Float {
        recordable.averagePower(forChannel: channelNumber)
    }
}
