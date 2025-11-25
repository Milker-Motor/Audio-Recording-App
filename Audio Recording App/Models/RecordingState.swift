//
//  RecordingState.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 24.11.2025.
//

import Foundation

class RecordingState: ObservableObject {
    @Published private(set) var state: AudioRecorderState
    @Published private(set) var secondsPlayback: Int = 0
    
    let format: AudioFormat
    let sampleRate: Double
    let url: (String) -> URL
    
    private var stopwatchTimer: Timer?
    
    init(state: AudioRecorderState = .stopped,
         format: AudioFormat,
         sampleRate: Double,
         url: @escaping (String) -> URL
    ) {
        self.state = state
        self.format = format
        self.sampleRate = sampleRate
        self.url = url
    }
}

extension RecordingState {
    func startNewRecording() {
        secondsPlayback = 0
        startStopwatch()
        state = .recording
    }
    
    func stopRecording() {
        stopwatchTimer?.invalidate()
        state = .stopped
    }
    
    func pauseRecording() {
        stopwatchTimer?.invalidate()
        state = .paused
    }
    
    func resumeRecording() {
        startStopwatch()
        state = .recording
    }
    
    private func startStopwatch() {
        stopwatchTimer?.invalidate()
        stopwatchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self, self.state == .recording else { return }
            self.secondsPlayback += 1
        }
    }
}
