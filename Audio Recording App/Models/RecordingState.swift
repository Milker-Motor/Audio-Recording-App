//
//  RecordingState.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 24.11.2025.
//

import Foundation

class RecordingState: ObservableObject {
//    @Published var mode: DetailMode
//    @Published var isPaused: Bool
    @Published private(set) var state: AudioRecorderState
    @Published private(set) var secondsPlayback: Int = 0
    
    let format: AudioFormat
    let sampleRate: Double
    let url: (String) -> URL
    
    private var stopwatchTimer: Timer?
    
    init(state: AudioRecorderState = .stopped,/*mode: DetailMode = .none, isPaused: Bool = false, */format: AudioFormat, sampleRate: Double, url: @escaping (String) -> URL) {
//        self.mode = mode
//        self.isPaused = isPaused
        self.state = state
        self.format = format
        self.sampleRate = sampleRate
        self.url = url
    }
}

extension RecordingState {
    func startNewRecording() {
        state = .recording
        secondsPlayback = 0
        startStopwatch()
    }
    
    func stopRecording() {
        state = .stopped
        stopwatchTimer?.invalidate()
    }
    
    func pauseRecording() {
        state = .paused
        stopwatchTimer?.invalidate()
    }
    
    func resumeRecording() {
        state = .recording
        startStopwatch()
    }
    
    private func startStopwatch() {
        stopwatchTimer?.invalidate()
        stopwatchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self, self.state == .recording else { return }
            self.secondsPlayback += 1
        }
    }
}
