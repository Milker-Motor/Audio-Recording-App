//
//  Recordable.swift
//  Audio Recording App
//
//  Created by Oleksii Lytvynov-Bohdanov on 22.11.2025.
//

import Foundation

protocol Recordable {
    func startNewRecording() throws
}

class RecordingState: ObservableObject {
    @Published var mode: DetailMode
    @Published var isPaused: Bool
    @Published private(set) var secondsPlayback: Int = 0
    
    let format: AudioFormat
    let sampleRate: Double
    let url: (String) -> URL
    
    private var stopwatchTimer: Timer?
    
    init(mode: DetailMode = .none, isPaused: Bool = false, format: AudioFormat, sampleRate: Double, url: @escaping (String) -> URL) {
        self.mode = mode
        self.isPaused = isPaused
        self.format = format
        self.sampleRate = sampleRate
        self.url = url
    }
}

public enum DetailMode: Equatable {
    case none
    case recording
    case playback
}

extension RecordingState: Recordable {
    func startNewRecording() throws {
        mode = .recording
        secondsPlayback = 0
        startStopwatch()
    }
    
    private func startStopwatch() {
        stopwatchTimer?.invalidate()
        stopwatchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self, self.mode == .recording else { return }
            self.secondsPlayback += 1
        }
    }
}
