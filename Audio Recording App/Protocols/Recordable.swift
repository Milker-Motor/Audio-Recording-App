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
    
    let format: AudioFormat
    let sampleRate: Double
    let url: (String) -> URL
    
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
