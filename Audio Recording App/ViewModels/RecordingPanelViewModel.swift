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
    var onSave: (RecordingRowItem) -> Void
    
    init(recordable: Recordable, dataStore: RecordingDataStore, onSave: @escaping (RecordingRowItem) -> Void) {
        self.recordable = recordable
        self.dataStore = dataStore
        self.onSave = onSave
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
        let item = try dataStore.insert(LocalRecordingItem(fileURL: url, duration: state.secondsPlayback, format: state.format))
        
        onSave(RecordingRowItem(name: item.name, durationInSeconds: Int(item.duration), date: item.createdAt.formatted(date: .abbreviated, time: .shortened), url: url))
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
