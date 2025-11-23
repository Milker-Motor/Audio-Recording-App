//
//  RecordingPanelViewModel.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 23.11.2025.
//

import SwiftUI

final class RecordingPanelViewModel: ObservableObject {
    private let recordable: Recordable
    @ObservedObject private(set) var recordableState: RecordingState
    @Published var uiError: AppError?
    
    init(recordable: Recordable, recordableState: RecordingState) {
        self.recordable = recordable
        self.recordableState = recordableState
    }
    
    var isPaused: Bool {
        recordableState.state == .paused
    }
    
    var timer: String {
        let duration = recordableState.secondsPlayback
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
    func startNewRecording() throws {
        do {
            try recordable.startNewRecording()
        } catch {
            Task { @MainActor in
                self.uiError = .recordingFailed(error.localizedDescription)
            }
        }
    }
    
    func stopRecording() {
        recordable.stopRecording()
    }
    
    func resumeRecording() {
        recordable.resumeRecording()
    }
    
    func pauseRecording() {
        recordable.pauseRecording()
    }
}
